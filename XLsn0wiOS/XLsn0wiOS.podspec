
Pod::Spec.new do |s|

  s.version      = "1.0.2"
  s.summary      = "Copyright © XLsn0w"
  s.author          = { "XLsn0w" => "xlsn0wios@outlook.com" }

  s.name         = "XLsn0wiOS"
  s.homepage     = "https://github.com/XLsn0wiOS/XLsn0wiOS"
  s.source       = { :git => "https://github.com/XLsn0wiOS/XLsn0wiOS.git", :tag => s.version.to_s }

  s.source_files    = "XLsn0wiOS/**/*.{h,m}"
  
  s.frameworks      = "UIKit", "Foundation"

  s.requires_arc    = true
  s.license         = "Copyright © XLsn0w"
  s.platform        = :ios, "9.0"

  s.dependency "MBProgressHUD"
  s.dependency "AFNetworking"
  s.dependency "SDWebImage"
  s.dependency "Masonry"
  s.dependency "ReactiveObjC"
  s.dependency "YYKit"
  s.dependency "XLsn0w"

end
