#
# Be sure to run `pod lib lint UIFadeLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UIFadeLabel'
  s.version          = '0.1.1'
  s.summary          = 'UIFadeLabel is a subclass of UILabel used to achieve the effect of gradually disappearing and appearing text.(UIFadeLabel是一个UILabel的子类，用以实现文字的渐隐渐现效果。)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Sfh03031/UIFadeLabel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sfh03031' => 'sfh894645252@163.com' }
  s.source           = { :git => 'https://github.com/Sfh03031/UIFadeLabel.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_versions   = '4'
  s.ios.deployment_target = '12.0'

  s.source_files = 'UIFadeLabel/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UIFadeLabel' => ['UIFadeLabel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
