require 'yaml'
require 'daemons'
require 'rest-client'
require 'spoc'
require 'fileutils'

id  = ARGV[0]
url = ARGV[1]

# remember and change back to current directory because daemonize chages to /
current_directory = File.dirname(File.expand_path($0))
Daemons.daemonize
FileUtils.cd(current_directory)

file_path = Spoc::FileTransfer.download_file(url,"images")
regions = Spoc::LightCV.find(file_path)
yml = YAML::dump(regions)
RestClient.get 'http://localhost:3000/backend/detect_result', {:params => { :image_id => id, :regions => yml}}

FileUtils.rm(file_path)
