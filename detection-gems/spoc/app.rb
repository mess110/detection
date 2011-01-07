#require File.join(File.dirname($0), 'lib/file_convert.rb')
#require File.join(File.dirname($0), 'lib/light_cv.rb')
#require File.join(File.dirname($0), 'lib/file_transfer.rb')
require 'spoc'

base64 = Spoc::FileConvert.encode("test.jpg")
Spoc::FileConvert.decode(base64, "output.jpg")
puts Spoc::LightCV.find("output.jpg")

Spoc::FileTransfer.client("localhost",2000,"output.jpg")

puts Spoc::FileTransfer.download_file("http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg","images")
