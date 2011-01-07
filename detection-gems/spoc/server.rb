#require File.join(File.dirname($0), 'lib/file_convert.rb')
#require File.join(File.dirname($0), 'lib/light_cv.rb')
#require File.join(File.dirname($0), 'lib/file_transfer.rb')
require 'spoc'

Spoc::FileTransfer.server(2000)
