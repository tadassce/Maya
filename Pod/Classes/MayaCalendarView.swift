//
//  MayaCalendarView.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

public class MayaCalendarView: UIView {

  private var backButton: UIButton = UIButton(type: .System)
  private var forwardButton: UIButton = UIButton(type: .System)
  private var monthLabel: UILabel = UILabel(frame: .zero)
  private var collectionView: UICollectionView
  private var collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

  public var dataSource: MayaCalendarDataSource?
  public var delegate:  MayaCalendarDelegate?

  @IBOutlet public var ibDataSource: AnyObject? {
    get { return dataSource }
    set { dataSource = newValue as? MayaCalendarDataSource }
  }
  @IBOutlet public var ibDelegate: AnyObject? {
    get { return delegate }
    set { delegate = newValue as? MayaCalendarDelegate }
  }

  @IBInspectable public var monthFont: UIFont = .boldSystemFontOfSize(18) {
    didSet {
      monthLabel.font = monthFont
    }
  }

  @IBInspectable public var weekdayFont: UIFont = .systemFontOfSize(15) {
    didSet {
      reloadData()
    }
  }

  @IBInspectable public var dayFont: UIFont = .systemFontOfSize(16) {
    didSet {
      reloadData()
    }
  }

  @IBInspectable public var weekdayTextColor: UIColor = UIColor.blackColor() {
    didSet {
      reloadData()
    }
  }

  @IBInspectable public var backButtonImage: UIImage? = MayaButtonImage.leftArrowImage {
    didSet {
      backButton.setImage(backButtonImage, forState: .Normal)
    }
  }

  @IBInspectable public var forwardButtonImage: UIImage? = MayaButtonImage.rightArrowImage {
    didSet {
      forwardButton.setImage(forwardButtonImage, forState: .Normal)
    }
  }

  public var currentMonth: MayaMonth {
    get {
      return _currentMonth
    }
    set {
      _currentMonth = newValue
      scrollToMonth(_currentMonth)
    }
  }

  private var _currentMonth: MayaMonth = MayaMonth(date: NSDate()) {
    didSet {
      if currentMonth.compare(firstMonth) == .OrderedAscending {
        firstMonth = currentMonth
      } else if currentMonth.compare(lastMonth) == .OrderedDescending {
        lastMonth = currentMonth
      }
      monthLabel.text = dataSource?.calendarMonthName?(currentMonth) ?? currentMonth.name
      backButton.enabled = currentMonth.numberOfMonthsUntil(firstMonth) != 0
      forwardButton.enabled = currentMonth.numberOfMonthsUntil(lastMonth) != 0
    }
  }

  public var firstMonth: MayaMonth = MayaMonth(date: NSDate()) {
    didSet {
      reloadData()
    }
  }

  public var lastMonth: MayaMonth = MayaMonth(date: NSDate()).monthWithOffset(12) {
    didSet {
      reloadData()
    }
  }

  public var weekdays: [String] = ["su", "mo", "tu", "we", "th", "fr", "sa"] {
    didSet {
      reloadData()
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

  override public func layoutSubviews() {
    collectionView.layoutIfNeeded()
    collectionView.reloadData()
    scrollToMonth(_currentMonth)
  }

}

// MARK: Setup
extension MayaCalendarView {

  private func setupViews() {
    setupButtons()
    setupMonthLabel()
    setupCollectionView()
  }

  private func setupButtons() {
    backButton.setImage(MayaButtonImage.leftArrowImage, forState: .Normal)
    backButton.tintColor = UIColor.blackColor()
    backButton.addTarget(self, action: "backClick", forControlEvents: .TouchUpInside)
    backButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(backButton)
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|-0-[backButton(44)]",
        options: [.AlignAllLeading], metrics: nil,
        views: ["backButton": backButton]))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|-0-[backButton(44)]",
        options: [.AlignAllLeading], metrics: nil,
        views: ["backButton": backButton]))

    forwardButton.setImage(MayaButtonImage.rightArrowImage, forState: .Normal)
    forwardButton.tintColor = UIColor.blackColor()
    forwardButton.addTarget(self, action: "forwardClick", forControlEvents: .TouchUpInside)
    forwardButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(forwardButton)
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:[forwardButton(44)]-0-|",
        options: [.AlignAllLeading], metrics: nil,
        views: ["forwardButton": forwardButton]))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|-0-[forwardButton(44)]",
        options: [.AlignAllLeading], metrics: nil,
        views: ["forwardButton": forwardButton]))

    backButton.enabled = currentMonth.numberOfMonthsUntil(firstMonth) != 0
    forwardButton.enabled = currentMonth.numberOfMonthsUntil(lastMonth) != 0
  }

  private func setupMonthLabel() {
    monthLabel.font = monthFont
    monthLabel.textAlignment = .Center
    monthLabel.text = dataSource?.calendarMonthName?(currentMonth) ?? currentMonth.name
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(monthLabel)
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:[backButton]-8-[monthLabel]-8-[forwardButton]",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,
        views: ["monthLabel": monthLabel, "forwardButton": forwardButton,
          "backButton": backButton]))
    addConstraint(NSLayoutConstraint(item: monthLabel, attribute: .CenterY, relatedBy: .Equal,
      toItem: backButton, attribute: .CenterY, multiplier: 1, constant: 0))
  }


  private func setupCollectionView() {
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsZero
    collectionViewFlowLayout.minimumLineSpacing = 0
    collectionViewFlowLayout.minimumInteritemSpacing = 0
    collectionView.collectionViewLayout = collectionViewFlowLayout
    collectionViewFlowLayout.scrollDirection = .Horizontal
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.pagingEnabled = true
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = UIColor.clearColor()
    collectionView.registerNib(UINib(nibName: "MayaCalendarMonthCollectionViewCell",
      bundle: NSBundle(forClass: self.dynamicType)),
      forCellWithReuseIdentifier: "MayaCalendarMonthCollectionViewCell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(collectionView)
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|-0-[collectionView]-0-|",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,
        views: ["collectionView": collectionView]))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:[monthLabel]-0-[collectionView]-0-|",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,
        views: ["monthLabel": monthLabel, "collectionView": collectionView]))
  }

  public func reloadData() {
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

  private func scrollToMonth(month: MayaMonth) {
    let index = firstMonth.numberOfMonthsUntil(month)
    guard index <= firstMonth.numberOfMonthsUntil(lastMonth) && index >= 0 else {
      return
    }
    let indexPath = NSIndexPath(forItem: index, inSection: 0)
    collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally,
      animated: true)
  }


}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MayaCalendarView: UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {

  public func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCellWithReuseIdentifier("MayaCalendarMonthCollectionViewCell",
        forIndexPath: indexPath)
      if let cell = cell as? MayaCalendarMonthCollectionViewCell {
        let month = monthForIndexPath(indexPath)
        cell.viewModel = MayaMonthViewModel(month: month, weekdays: weekdays,
          weekdayTextColor: weekdayTextColor, weekdayFont: weekdayFont, dayFont: dayFont,
          dataSource: dataSource, dayClicked: dayClicked)
      }

      return cell
  }

  public func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return firstMonth.numberOfMonthsUntil(lastMonth) + 1
  }

  public func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return collectionView.bounds.size
  }

  public func scrollViewDidScroll(scrollView: UIScrollView) {
    let month = monthForIndexPath(NSIndexPath(forItem: currentPage(), inSection: 0))
    if month != _currentMonth {
      _currentMonth = month
    }
  }

}

// MARK: Helpers
extension MayaCalendarView {

  private func dayClicked(date: MayaDate) {
    if date.compare(currentMonth.firstDate) == .OrderedAscending {
      scrollToMonth(currentMonth.previousMonth)
    } else if date.compare(currentMonth.lastDate) == .OrderedDescending {
      scrollToMonth(currentMonth.nextMonth)
    }
    delegate?.calendarDidSelectDate?(date)
  }

  private func monthForIndexPath(indexPath: NSIndexPath) -> MayaMonth {
    if indexPath.row == 0 {
      return firstMonth
    }
    return firstMonth.monthWithOffset(indexPath.item)
  }

  private func currentPage() -> Int {
    let currentPage = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
    return Int(round(currentPage))
  }

}