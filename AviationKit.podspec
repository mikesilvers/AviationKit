#
# Be sure to run `pod lib lint AviationKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AviationKit'
  s.version          = '1.1.0'
  s.summary          = 'AviationKit provides an interface with the FAA weather servers (aviationweather.gov) for aviation related apps.'
  s.description      = <<-DESC
  AviationKit provides an interface with the FAA weather servers (aviationweather.gov).  These services are provided using XML from the servers.  We include `Codable` data models allowing for easy encoding and decoding of the data models.  The services include:
* TAF
* METAR
* AIR/SIGMET
* G-AIRMET
* Aircraft Reports
* Station Info
                       DESC

  s.homepage         = 'https://github.com/mikesilvers/AviationKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mike Silvers' => 'mikesilvers@gmail.com' }
  s.source           = { :git => 'https://github.com/mikesilvers/AviationKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'AviationKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AviationKit' => ['AviationKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
