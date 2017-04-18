//
//  MayaCalendarView.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

open class MayaCalendarView: UIView {

  fileprivate var backButton: UIButton = UIButton(type: .system)
  fileprivate var forwardButton: UIButton = UIButton(type: .system)
  fileprivate var monthLabel: UILabel = UILabel(frame: .zero)
  fileprivate var collectionView: UICollectionView
  fileprivate var collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

  open var dataSource: MayaCalendarDataSource? {
    didSet {
      reloadData()
    }
  }
  open var delegate:  MayaCalendarDelegate?

  @IBOutlet open var ibDataSource: AnyObject? {
    get { return dataSource }
    set { dataSource = newValue as? MayaCalendarDataSource }
  }
  @IBOutlet open var ibDelegate: AnyObject? {
    get { return delegate }
    set { delegate = newValue as? MayaCalendarDelegate }
  }

  @IBInspectable open var monthFont: UIFont = .boldSystemFont(ofSize: 18) {
    didSet {
      monthLabel.font = monthFont
    }
  }

  @IBInspectable open var weekdayFont: UIFont = .systemFont(ofSize: 15) {
    didSet {
      reloadData()
    }
  }

  @IBInspectable open var dayFont: UIFont = .systemFont(ofSize: 16) {
    didSet {
      reloadData()
    }
  }

  @IBInspectable open var weekdayTextColor: UIColor = UIColor.black {
    didSet {
      reloadData()
    }
  }

  @IBInspectable open var backButtonImage: UIImage? = MayaButtonImage.leftArrowImage {
    didSet {
      backButton.setImage(backButtonImage, for: UIControlState())
    }
  }

  @IBInspectable open var forwardButtonImage: UIImage? = MayaButtonImage.rightArrowImage {
    didSet {
      forwardButton.setImage(forwardButtonImage, for: UIControlState())
    }
  }

  @IBInspectable open var headerHeight: CGFloat = 44 {
    didSet {
      setupButtonConstraints()
    }
  }

  open var currentMonth: MayaMonth {
    get {
      return _currentMonth
    }
    set {
      _currentMonth = newValue
      scrollToMonth(_currentMonth)
    }
  }

  fileprivate var _currentMonth: MayaMonth = MayaMonth(date: Date()) {
    didSet {
      if currentMonth.compare(firstMonth) == .orderedAscending {
        firstMonth = currentMonth
      } else if currentMonth.compare(lastMonth) == .orderedDescending {
        lastMonth = currentMonth
      }
      UIView.transition(with: monthLabel, duration: 0.25, options: .transitionCrossDissolve,
                                animations: { () -> Void in
                                  self.monthLabel.text = self.dataSource?.calendarMonthName?(self.currentMonth) ??
                                    self.currentMonth.name
        }, completion: nil)
      backButton.isEnabled = currentMonth.numberOfMonthsUntil(firstMonth) != 0
      forwardButton.isEnabled = currentMonth.numberOfMonthsUntil(lastMonth) != 0
    }
  }

  open var firstMonth: MayaMonth = MayaMonth(date: Date()) {
    didSet {
      reloadData()
    }
  }

  open var lastMonth: MayaMonth = MayaMonth(date: Date()).monthWithOffset(12) {
    didSet {
      reloadData()
    }
  }

  open var weekdays: [String] = ["su", "mo", "tu", "we", "th", "fr", "sa"] {
    didSet {
      reloadData()
    }
  }

  override open var frame: CGRect {
    didSet {
      collectionViewFlowLayout.invalidateLayout()
    }
  }

  override public init(frame: CGRect) {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    super.init(frame: frame)
    setupViews()
  }

  required public init?(coder aDecoder: NSCoder) {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    super.init(coder: aDecoder)
    setupViews()
  }

  override open func layoutSubviews() {
    collectionViewFlowLayout.invalidateLayout()
    collectionView.reloadData()
    scrollToMonth(_currentMonth)
  }

}

// MARK: Setup
extension MayaCalendarView {

  fileprivate func setupViews() {
    setupButtons()
    setupMonthLabel()
    setupCollectionView()
  }

  fileprivate func setupButtons() {
    backButton.setImage(MayaButtonImage.leftArrowImage, for: UIControlState())
    backButton.tintColor = UIColor.black
    backButton.addTarget(self, action: #selector(MayaCalendarView.backClick),
                         for: .touchUpInside)
    backButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(backButton)


    forwardButton.setImage(MayaButtonImage.rightArrowImage, for: UIControlState())
    forwardButton.tintColor = UIColor.black
    forwardButton.addTarget(self, action: #selector(MayaCalendarView.forwardClick),
                            for: .touchUpInside)
    forwardButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(forwardButton)


    backButton.isEnabled = currentMonth.numberOfMonthsUntil(firstMonth) != 0
    forwardButton.isEnabled = currentMonth.numberOfMonthsUntil(lastMonth) != 0
  }

  fileprivate func setupButtonConstraints() {
    removeConstraints(backButton)
    removeConstraints(forwardButton)
    addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "H:|-0-[backButton(44)]",
        options: [.alignAllLeading], metrics: nil,
        views: ["backButton": backButton]))
    addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "V:|-0-[backButton(\(headerHeight))]",
        options: [.alignAllLeading], metrics: nil,
        views: ["backButton": backButton]))

    addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "H:[forwardButton(44)]-0-|",
        options: [.alignAllLeading], metrics: nil,
        views: ["forwardButton": forwardButton]))
    addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "V:|-0-[forwardButton(\(headerHeight))]",
        options: [.alignAllLeading], metrics: nil,
        views: ["forwardButton": forwardButton]))
    addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "H:[backButton]-8-[monthLabel]-8-[forwardButton]",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,
        views: ["monthLabel": monthLabel, "forwardButton": forwardButton,
          "backButton": backButton]))
    addConstraint(NSLayoutConstraint(item: monthLabel, attribute: .centerY, relatedBy: .equal,
      toItem: backButton, attribute: .centerY, multiplier: 1, constant: 0))
  }

  fileprivate func setupMonthLabel() {
    monthLabel.font = monthFont
    monthLabel.textAlignment = .center
    monthLabel.text = dataSource?.calendarMonthName?(currentMonth) ?? currentMonth.name
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(monthLabel)

    setupButtonConstraints()

  }


  fileprivate func setupCollectionView() {
    collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
    collectionViewFlowLayout.minimumLineSpacing = 0
    collectionViewFlowLayout.minimumInteritemSpacing = 0
    collectionView.collectionViewLayout = collectionViewFlowLayout
    collectionViewFlowLayout.scrollDirection = .horizontal
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isPagingEnabled = true
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = UIColor.clear
    collectionView.register(UINib(nibName: "MayaCalendarMonthCollectionViewCell",
      bundle: Bundle(for: MayaCalendarView.self)),
                               forCellWithReuseIdentifier: "MayaCalendarMonthCollectionViewCell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(collectionView)
    addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "H:|-0-[collectionView]-0-|",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,
        views: ["collectionView": collectionView]))
    addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "V:[monthLabel]-0-[collectionView]-0-|",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,
        views: ["monthLabel": monthLabel, "collectionView": collectionView]))
  }

  public func reloadData() {
    monthLabel.text = dataSource?.calendarMonthName?(currentMonth) ?? currentMonth.name
    collectionView.reloadData()
  }

}

// MARK: Actions
extension MayaCalendarView {

  @IBAction func backClick() {
    scrollToMonth(currentMonth.previousMonth)
  }

  @IBAction func forwardClick() {
    scrollToMonth(currentMonth.nextMonth)
  }

  fileprivate func scrollToMonth(_ month: MayaMonth) {
    let index = firstMonth.numberOfMonthsUntil(month)
    guard index <= firstMonth.numberOfMonthsUntil(lastMonth) && index >= 0 else {
      return
    }
    let indexPath = IndexPath(item: index, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally,
                                           animated: true)
  }


}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MayaCalendarView: UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {

  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "MayaCalendarMonthCollectionViewCell",
                                              for: indexPath)
    if let cell = cell as? MayaCalendarMonthCollectionViewCell {
      let month = monthForIndexPath(indexPath)
      cell.viewModel = MayaMonthViewModel(month: month, weekdays: weekdays,
                                          weekdayTextColor: weekdayTextColor, weekdayFont: weekdayFont, dayFont: dayFont,
                                          dataSource: dataSource, dayClicked: dayClicked)
    }

    return cell
  }

  public func collectionView(_ collectionView: UICollectionView,
                             numberOfItemsInSection section: Int) -> Int {
    return firstMonth.numberOfMonthsUntil(lastMonth) + 1
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                                    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: bounds.size.width, height: bounds.size.height - 44)
  }

  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let month = monthForIndexPath(IndexPath(item: currentPage(), section: 0))
    if month != _currentMonth {
      _currentMonth = month
      delegate?.calendarDidChangeMonth?(_currentMonth)
    }
  }

}

// MARK: Helpers
extension MayaCalendarView {

  fileprivate func dayClicked(_ date: MayaDate) {
    if date.compare(currentMonth.firstDate) == .orderedAscending {
      scrollToMonth(currentMonth.previousMonth)
    } else if date.compare(currentMonth.lastDate) == .orderedDescending {
      scrollToMonth(currentMonth.nextMonth)
    }
    delegate?.calendarDidSelectDate?(date)
  }

  fileprivate func monthForIndexPath(_ indexPath: IndexPath) -> MayaMonth {
    if indexPath.row == 0 {
      return firstMonth
    }
    return firstMonth.monthWithOffset(indexPath.item)
  }

  fileprivate func currentPage() -> Int {
    let currentPage = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
    return Int(round(currentPage))
  }

  fileprivate func removeConstraints(_ view: UIView) {
    var list = [NSLayoutConstraint]()
    if let superview = view.superview {
      for constraint in superview.constraints {
        if constraint.firstItem as? UIView == view || constraint.secondItem as? UIView == view {
          list.append(constraint)
        }
      }
      view.superview?.removeConstraints(list)
      view.removeConstraints(view.constraints)
    }
  }
  
}
