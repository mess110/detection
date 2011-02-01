require 'rubygems'
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

get '/' do
  'nothing should expload'
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
  RestClient.get "http://#{settings.ui_server}/backend/register", {:params => params}
  'done'
end

get '/detect' do
  url = params[:url]
  image_id = params[:image_id]
  logger.info "Request to download #{url} with image_id #{image_id} received"

  cmd = "ruby daemon.rb #{image_id} #{url.shellescape} #{settings.user.shellescape} #{settings.pass.shellescape}&"
  logger.info "Executing: #{cmd}"
  system(cmd)
  '42'
end
