require 'rubygems'
require 'cvwrapper'
#require 'lib/cvwrapper'

puts CVWrapper::Detector.find "us.jpg"
puts CVWrapper::Detector.find "us.jpg", CVWrapper::HaarCascade::FRONTAL_FACE_DEFAULT

