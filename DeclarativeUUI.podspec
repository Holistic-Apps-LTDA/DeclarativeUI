Pod::Spec.new do |spec|

  spec.name         = "DeclarativeUUI"
  spec.version      = "0.0.9"
  spec.summary      = "A library to develop UI declaratively in Swift."

  spec.description  = <<-DESC
This library helps you to develop declaratively your UI in Swift. 
                   DESC

  spec.homepage     = "https://github.com/Holistic-Apps-LTDA/DeclarativeUI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Holistic Apps LTDA" => "holistic.apps.solutions@gmail.com" }

  spec.ios.deployment_target = "11.0"

  spec.source        = { :git => "https://github.com/Holistic-Apps-LTDA/DeclarativeUI.git", :tag => "#{spec.version}" }
  spec.source_files  = "DeclarativeUI/**/*.{h,m,swift}"

  spec.requires_arc = true
  spec.swift_version = '5.0'
  spec.frameworks = "PDFKit", "UIKit"

end
