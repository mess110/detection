class SecureApplicationController < ApplicationController

  before_filter :authenticate

  private

  # Basic HTTP Authentication method
  def authenticate
    authenticate_or_request_with_http_basic do |key, secret|
      valid_key = ApiKey.find(:all, :params => { :key => key, :secret => secret })

      if valid_key[0]
        session[:key_id] = valid_key[0].id
      end
    end
  end
end
