#
# Be sure to run `pod lib lint GetRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GetRouter'
  s.version          = '1.0.5'
  s.summary          = '无侵入的Swift路由组件'

  s.homepage         = 'https://github.com/syk83528/GetRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'syk83528' => '270081841@qq.com' }
  s.source           = { :git => 'https://github.com/syk83528/GetRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'GetRouter/Classes/**/*'
  
  s.swift_version = "5.0"
  # s.resource_bundles = {
  #   'GetRouter' => ['GetRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
