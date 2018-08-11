Pod::Spec.new do |s|
s.name         = "EAAlertView"
s.version      = "0.1.1"
s.summary      = "iOS 11 style alerts"
s.homepage     = "https://github.com/EgzonArifi/EAAlertView"
s.license      = "MIT"
s.author       = { "Egzon Arifi" => "egzon.r.arifi@gmail.com" }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/EgzonArifi/EAAlertView.git", :tag => "#{s.version}" }
s.swift_version = '4.0'
s.source_files  = "EAAlertView/*.{swift,h}"
end
