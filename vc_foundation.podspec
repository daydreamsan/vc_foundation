#
# Be sure to run `pod lib lint vc_foundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'vc_foundation'
  s.version          = '0.2.3'
  s.summary          = 'A short description of vc_foundation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
维词APP基础配置工程.
                       DESC

  s.homepage         = 'https://github.com/daydreamsan/vc_foundation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'daydreamsan' => '1051747376@qq.com' }
  s.source           = { :git => 'https://github.com/daydreamsan/vc_foundation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'vc_foundation/Classes/**/*'
  
  # s.resource_bundles = {
  #   'vc_foundation' => ['vc_foundation/Assets/*.png']
  # }

   s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
   s.dependency 'YYKit', '~> 1.0.9'
   s.dependency 'Masonry', '~> 1.0.2'
   s.dependency 'SVProgressHUD', '~> 2.2.5'
end
