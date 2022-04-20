# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def app_test
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SwiftLint'
  pod 'Kingfisher'
  pod 'RxDataSources'
end

def unit_testing
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxTest'
  pod 'RxBlocking'
end

target 'MuslimPrayerApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  app_test

  # Pods for MuslimPrayerApp

  target 'MuslimPrayerAppTests' do
    inherit! :search_paths
    
    unit_testing
    
  end

  target 'MuslimPrayerAppUITests' do
    # Pods for testing
  end

end
