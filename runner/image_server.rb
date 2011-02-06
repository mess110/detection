require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'shellwords'
require 'logger'

begin
  require './config/image_settings.rb'
rescue LoadError => e
  puts "Edit ./config/image_settings.rb!"
  exit 0
end

get '/' do
  'image server'
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

  cmd = "ruby1.9.1 daemon.rb #{image_id} #{url.shellescape} #{settings.user.shellescape} #{settings.pass.shellescape}&"
  logger.info "Executing: #{cmd}"
  system(cmd)
  '42'
end
