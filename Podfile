# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StarWarsWorld' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

	pod 'Alamofire'
  pod 'RealmSwift'
        
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end
