require 'httparty'

class Detection
  include HTTParty
  base_uri 'detection.myvhost.de'

  def self.auth(params)
    get('/auth/', :query => params)
  end

  def self.detect(params)
    basic_auth params[:key], params[:secret] 
    post('/detect/new', :query => {:url => params[:url] })
  end
end
