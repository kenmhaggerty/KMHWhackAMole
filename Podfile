# Podfile
# KMHWhackAMole (WAM)
# Ken M. Haggerty
# CREATED: Dec 11 2016
# EDITED:  Dec 11 2016

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def sharedPods
end

def testPods
  pod 'Specta', '~> 1.0'
  pod 'Expecta', '~> 1.0'
  pod 'KIF'
end

target 'KMHWhackAMole' do
  sharedPods
end

target 'KMHWhackAMoleTests' do
  sharedPods
  testPods
end
