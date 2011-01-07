require 'yaml'
require 'daemons'
require 'rest-client'
require 'spoc'
require 'fileutils'

current_directory = File.dirname(File.expand_path($0))

Daemons.daemonize

FileUtils.cd(current_directory)

file_path = Spoc::FileTransfer.download_file("http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg","images")
array = Spoc::LightCV.find(file_path)
yml = YAML::dump(array)
RestClient.get 'http://localhost:3000/backend/detect_result', {:params => { :image_id => 3, :regions => yml}}

FileUtils.rm(file_path)
