# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GIFSelection' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GIFSelection

pod 'SDWebImage'
pod 'Kingfisher'

end
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
                  config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
                  config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
               end
          end
   end
end
