Pod::Spec.new do |s|
  s.name             = 'KNSwitcher'
  s.version          = '1.0'
  s.summary          = 'Custom everything in Switcher with animation'
 
  s.description      = <<-DESC
Custom everything in Switcher with animation. Support using xib or code. Change color or add image easily right in xib/Storyboard file.
                       DESC
 
  s.homepage         = 'https://github.com/knn90/Switcher'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Khoi Nguyen' => 'nguyenkhoi2190@gmail.com' }
  s.source           = { :git => 'https://github.com/knn90/Switcher.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.3'
  s.source_files = 'KNSwitcher/KNSwitcher.swift'
end