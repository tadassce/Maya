#
# Be sure to run `pod lib lint Maya.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Maya"
  s.version          = "1.1.8"
  s.summary          = "Maya is a customizable calendar library with an out of the box MayaCalendarView"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
Maya is a customizable calendar library with an out of the box MayaCalendarView.
Maya also includes a few helper classes to make managing dates a little bit easier (MayaDate, MayaWeekday and MayaMonth)
                       DESC

  s.homepage         = "https://github.com/ivanbruel/Maya"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ivan Bruel" => "ivan.bruel@gmail.com" }
  s.source           = { :git => "https://github.com/ivanbruel/Maya.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ivanbruel'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'SnapKit', '~> 0.19.1'
end
