Pod::Spec.new do |s|
s.name         = "EAAlertView"
s.version      = "0.1.0"
s.summary      = "iOS 11 style alerts"
s.homepage     = "https://github.com/EgzonArifi/EAAlertView"
s.license      = "MIT"
s.author       = { "Egzon Arifi" => "egzon.r.arifi@gmail.com" }
s.platform     = :ios, "11.0"
s.source       = { :git => "https://github.com/EgzonArifi/EAAlertView.git", :branch => "master",
:tag => s.version.to_s }
s.source_files  = "EAAlertView/**/*.{swift,h}"
end
