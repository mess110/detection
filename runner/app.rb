require 'sinatra'
require 'rest_client'
require 'shellwords'

get '/' do
  'welcome'
end

get '/register' do
  params = {
    :host => "localhost",
    :port => 3001,
    :file_transfer_port => 4001
  }
  RestClient.get 'http://localhost:3000/scheduler/register', {:params => params}
  'done'
end

get '/detect' do
  system("ruby1.9.1 daemons.rb #{params[:image_id]} #{params[:url].shellescape} &")
  return "200"
end
