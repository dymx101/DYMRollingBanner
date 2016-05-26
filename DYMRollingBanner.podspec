#
# Be sure to run `pod lib lint DYMRollingBanner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "DYMRollingBanner"
s.version          = "2.1.6"
s.summary          = "A buttery-smooth Infinite Banner Scrolling View Controller, supports both local and remote images and is 100% compatible with AutoLayout."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description      = <<-DESC
DYMRollingBanner is a clean and easy-to-use banner rolling control for your app's homepage screen which need to show some rolling banners.It supports both local and remote images and is 100% compatible with AutoLayout.
DESC

s.homepage         = "https://github.com/dymx101/DYMRollingBanner"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "Yiming Dong" => "dymx101@hotmail.com" }
s.source           = { :git => "https://github.com/dymx101/DYMRollingBanner.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/dymx101'

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*'
s.resource_bundles = {
'DYMRollingBanner' => ['Pod/Assets/*.png']
}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'

# s.dependency 'SDWebImage', '~> 3.7.3'
end
