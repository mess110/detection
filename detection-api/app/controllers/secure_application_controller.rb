class SecureApplicationController < ApplicationController

  before_filter :http_basic_authenticate

  private

  # Basic HTTP Authentication method
  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |key, secret|
      valid_key = ApiKey.find(:all, :params => { :key => key, :secret => secret })

      if valid_key[0]
        #if valid_key[0].block == 0
          session[:key_id] = valid_key[0].id
        #else
          #raise 'banned! contact admin!'
        #end
      else
        raise Exceptions::NotMyFault.new(ERROR_INVALID_API)
      end
    end
  end
end
