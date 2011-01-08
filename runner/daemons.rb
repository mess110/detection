require 'yaml'
require 'daemons'
require 'rest-client'
require 'spoc'
require 'fileutils'
require 'logger'

id  = ARGV[0]
url = ARGV[1]

# remember and change back to current directory because daemonize chages to '/'
current_directory = File.dirname(File.expand_path($0))
Daemons.daemonize
FileUtils.cd(current_directory)

$logger = Logger.new("runner.log")
$logger.info "--------------------------"
$logger.info "Downloading from #{url}"
file_path = Spoc::FileTransfer.download_file(url,"images")
#file_path = "images/test.jpg"
$logger.info "Saved to #{file_path}"

$logger.info "Scanning"
regions = Spoc::LightCV.find(file_path)
yml = YAML::dump(regions)

$logger.info "Sending result to image with ID = #{id}"
RestClient.get 'http://localhost:3000/backend/detect_result', {:params => { :image_id => id, :regions => yml}}

$logger.info "deleting file #{file_path}"
FileUtils.rm(file_path)
$logger.info "--------------------------"
