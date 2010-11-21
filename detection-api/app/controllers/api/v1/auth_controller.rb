class Api::V1::AuthController < ApplicationController

  def index
    if !(params[:email] && !params[:email].blank?)
      raise Exceptions::NotMyFault.new(ERROR_REQUIRE_EMAIL)
    end

    if !(params[:pass] && !params[:pass].blank?)
      raise Exceptions::NotMyFault.new(ERROR_REQUIRE_PASS)
    end

    #do a lot of security checks
    user = User.find(:first, :params => { :email => params[:email]})
    if user
      #if user password is correct
      if user.password?(params[:pass])
        response = format_response(user)
        render :partial => "api/v1/auth.xml.builder", :locals => { :response => response }
      else
        raise Exceptions::NotMyFault.new(ERROR_INVALID_LOGIN)
      end
    else
      user = User.new(:email => params[:email], :pass => params[:pass])
      if user.save
        response = format_response(user)
        render :partial => "api/v1/auth.xml.builder", :locals => { :response => response }
      else
        raise Exceptions::NotMyFault.new(user.errors.full_messages[0])
      end
    end
  end

  private

  def format_response(user)
    key = user.api_key
    {
      :email    => user.email,
      :key      => key.key,
      :secret   => key.secret
    }
  end
end
