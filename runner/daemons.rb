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
begin
  $logger.info "--------------------------"
  $logger.info "Downloading from #{url}"
  begin
    file_path = Spoc::FileTransfer.download_file(url,"images")
  rescue
    raise Exception.new("Can not download image")
  end
  #file_path = "images/test.jpg"
  $logger.info "Saved to #{file_path}"

  $logger.info "Scanning"
  begin
    regions = Spoc::LightCV.find(file_path)
  rescue
    raise Exception.new("Can not open image to scan for faces")
  end
  yml = YAML::dump(regions)

  $logger.info "Sending result to image with ID = #{id}"
  RestClient.get 'http://localhost:3000/backend/detect_result', {:params => { :image_id => id, :regions => yml}}

  $logger.info "deleting file #{file_path}"
  FileUtils.rm(file_path)
  $logger.info "--------------------------"
rescue Exception => e
  RestClient.get 'http://localhost:3000/backend/detect_result', {:params => { :image_id => id, :error_message => e.message}}
  $logger.info e.message
  $logger.info "--------------------------"
end
