# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Card' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Card
  
  pod "AAII", :git => "https://github.com/EstevanBR/AAII.git"

  target 'CardTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CardUITests' do
    # Pods for testing
  end

end
