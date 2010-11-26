class Api::V1::AuthController < ApplicationController

  def index
    if !(params[:email] && !params[:email].blank?)
      render_error(ERROR_REQUIRE_EMAIL) and return
    end

    if !(params[:pass] && !params[:pass].blank?)
      render_error(ERROR_REQUIRE_PASS) and return
    end

    #do a lot of security checks
    user = User.find(:first, :params => { :email => params[:email]})
    if user
      #if user password is correct
      if user.password?(params[:pass])
        response = format_response(user)
        render :partial => "api/v1/auth.xml.builder", :locals => { :response => response }
      else
        render_error(ERROR_INVALID_LOGIN) and return
      end
    else
      user = User.new(:email => params[:email], :pass => params[:pass])
      if user.save
        response = format_response(user)
        render :partial => "api/v1/auth.xml.builder", :locals => { :response => response }
      else
        render_error(user.errors.full_messages[0]) and return
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
