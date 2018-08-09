source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'SearchFilter' do
    # Alamofire HTTP networking library
	pod 'Alamofire', '~> 4.0'
	pod 'AlamofireObjectMapper', :git => 'https://github.com/tristanhimmelman/AlamofireObjectMapper.git', :branch => 'swift-4'
	pod 'ObjectMapper', '~> 3.0'
	pod 'Kingfisher'
	pod 'RangeSeekSlider'
	# SwiftyJson JSON parsing library
	pod 'SwiftyJSON'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end