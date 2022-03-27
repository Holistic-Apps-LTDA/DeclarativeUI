Pod::Spec.new do |spec|

  spec.name         = "DeclarativeUI"
  spec.version      = "0.0.1"
  spec.summary      = "A library to develop UI declaratively in Swift."

  spec.description  = <<-DESC
A declarative UI library. With declarativeUI you can develop UI similar to SwiftUI, with iOS 11.0 support.
                   DESC

  spec.homepage     = "https://github.com/Holistic-Apps-LTDA/DeclarativeUI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Holistic Apps LTDA" => "holistic.apps.solutions@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.6"

  spec.source        = { :git => "https://github.com/Holistic-Apps-LTDA/DeclarativeUI.git", :tag => "#{spec.version}" }
  spec.source_files  = "DeclarativeUI/**/*.{h,m,swift}"

end
