require 'sinatra'
require 'rest_client'
require 'shellwords'
require 'logger'

begin
  require './settings.rb'
rescue LoadError => e
  puts "Configure settings.rb!"
  exit 0
end

get '/ping' do
  logger.info "ping me ping me ping me"
end

get '/register' do
  params = {
    :host => settings.host,
    :port => settings.port,
    :file_transfer_port => settings.file_transfer_port
  }
  RestClient.get "http://#{settings.ui_server}/scheduler/register", {:params => params}
  'done'
end

get '/detect' do
  url = params[:url]
  image_id = params[:image_id]
  logger.info "Request to download #{url} with image_id #{image_id} received"

  system("ruby1.9.1 daemons.rb #{image_id} #{url.shellescape} &")
  '42'
end
