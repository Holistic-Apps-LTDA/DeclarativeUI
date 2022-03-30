Pod::Spec.new do |spec|

  spec.name         = "DeclarativeUI"
  spec.version      = "0.0.4"
  spec.summary      = "A library to develop UI declaratively in Swift."

  spec.description  = <<-DESC
This library helps you to develop declaratively your UI in Swift. 
                   DESC

  spec.homepage     = "https://github.com/Holistic-Apps-LTDA/DeclarativeUI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Holisti Apps LTDA" => "holistic.apps.solutions@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.osx.deployment_target = '10.13'
  spec.tvos.deployment_target = '11.0'
  spec.watchos.deployment_target = '4.0'

  spec.swift_versions = ['5.6']

  spec.source        = { :git => "https://github.com/Holistic-Apps-LTDA/DeclarativeUI.git", :tag => "#{spec.version}" }
  spec.source_files  = "DeclarativeUI/**/*.{h,m,swift}"

end
