# Maya

![Maya](http://i.imgur.com/iYRseDS.png?1)

[![CI Status](http://img.shields.io/travis/Ivan Bruel/Maya.svg?style=flat)](https://travis-ci.org/Ivan Bruel/Maya)
[![Version](https://img.shields.io/cocoapods/v/Maya.svg?style=flat)](http://cocoapods.org/pods/Maya)
[![License](https://img.shields.io/cocoapods/l/Maya.svg?style=flat)](http://cocoapods.org/pods/Maya)
[![Platform](https://img.shields.io/cocoapods/p/Maya.svg?style=flat)](http://cocoapods.org/pods/Maya)

**Maya** is a customizable calendar library with an out of the box `MayaCalendarView`.

**Maya** also includes a few helper classes to make managing dates a little bit easier (`MayaDate`, `MayaWeekday` and `MayaMonth`)

## Installation

Maya is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Maya'
```

## Usage

`MayaCalendarView` support both usage both through **xibs** and **programatically**.

### Programatically 

You can create a `MayaCalendarView` object by initializating it like any other `UIView` subclass.

```swift
import Maya

class YourViewController: UIViewController {
  
  var calendarView: MayaCalendarView!
  
  override func viewDidLoad() {
    calendarView = MayaCalendarView(frame: view.bounds)
    view.addSubview(calendarView)
  }
}
```

### XIBs

To add a `MayaCalendarView` to your XIB (or Storyboard) all you have to do is drag a `UIView` from the **Object Library** and change its class to `MayaCalendarView`.

![Step1](http://i.imgur.com/AldtNsc.png)

![Step2](http://i.imgur.com/cTiZCmp.png)

## Properties

`MayaCalendarView` in order to avoid potential performance issues uses a range of months and a current month as its inner data model.

You are free to set the `firstMonth`, `lastMonth` and `currentMonth` values and the calendar will adapt accordingly.

## Customizing

`MayaCalendarView` allows changing a lot of values to better suit your need:

- `weekdays`: An array of 7 strings representing the weekdays starting on Sunday and ending in Saturday. (defaults to `su, mo, tu, we, th, fr, sa`)
- `monthFont`: The font which will be used to write the month name. (defaults to `UIFont.boldSystemOfSize(18)`)
- `weekdayFont`: The font which will be used to write the weekday name. (defaults to `UIFont.systemFontOfSize(15)`)
- `dayFont`: The font which will be used to write the day number. (defauls to `UIFont.systemFontOfSize(16)`)
- `weekdayTextColor`: The color to write the weekdays name with. (defaults to `UIColor.blackColor()`)
 
## DataSource

The main purpose of this lib is allowing your `dataSource` to be what customizes the look of each day.

`MayaDataSource` allows customization through the following functions:

- `calendarMonthName(month: MayaMonth) -> String?`: The name for each given month. (defaults to full month name, e.g. December)
- `calendarTextColorForDate(date: MayaDate) -> UIColor?`: The color to write the day numbers with. (defaults to `UIColor.blackColor()`)
- `calendarBackgroundColorForDate(date: MayaDate) -> UIColor?`: the color to set on the day's background. (defaults to `UIColor.clearColor()`)
 
## Delegate

In order to interact with the `MayaCalendarView` you can also set the `delegate` property.

`MayaDelegate` allows receiving notification of the following actions:

- `func calendarDidSelectDate(date: MayaDate)`: called when the user clicks a given date inside the calendar.
- `func calendarDidChangeMonth(month: MayaMonth)`: called when either the user clicks the arrow buttons or scrolls between months.

## Requirements

iOS 9.0+

## Sample

There is a sample project in the `Example` directory.

## Author

Ivan Bruel, [@ivanbruel](http://twitter.com/ivanbruel)

## License

Maya is available under the MIT license. See the LICENSE file for more info.
