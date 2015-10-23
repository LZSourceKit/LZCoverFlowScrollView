Pod::Spec.new do |s|
  s.name         = "LZCoverFlowScrollView"
  s.version      = "0.0.1"
  s.summary      = "A enlarge animation effect with scrolling."
  s.homepage     = "https://github.com/LZSourceKit/LZCoverFlowScrollView.git"
  s.license      = "MIT"
  s.author       = { "lizi" => "appDeveloperDenny@hotmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/LZSourceKit/LZCoverFlowScrollView.git", :tag => "0.0.1" }
  s.source_files = "LZCoverFlowScrollView/*.{h,m}"
  s.ios.framework    = "UIKit"
  s.requires_arc = true
end
