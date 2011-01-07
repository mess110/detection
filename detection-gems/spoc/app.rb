#require File.join(File.dirname($0), 'lib/file_convert.rb')
#require File.join(File.dirname($0), 'lib/light_cv.rb')
require 'spoc'

base64 = Spoc::FileConvert.encode("test.jpg")
Spoc::FileConvert.decode(base64, "output.jpg")
puts Spoc::LightCV.find("output.jpg")

# check if it was installed

