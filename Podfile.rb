# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Card' do
  use_frameworks!
  
  pod "AAII", :git => "https://github.com/EstevanBR/AAII.git"
end
