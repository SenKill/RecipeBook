# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

target 'RecipeBook' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for RecipeBook
  
  pod 'TagListView'
  pod 'Alamofire'
  pod 'AlamofireImage'
  
  target 'RecipeBookTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'RecipeBookUITests' do
    # Pods for testing
  end
  
end
