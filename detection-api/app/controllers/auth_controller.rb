class AuthController < ApplicationController

  def index
    if !(params[:email] && !params[:email].blank?)
      raise Exceptions::NotMyFault.new(ERROR_REQUIRE_EMAIL)
    end

    if !(params[:pass] && !params[:pass].blank?)
      raise Exceptions::NotMyFault.new(ERROR_REQUIRE_PASS)
    end

    #do a lot of security checks
    user = User.find(:all, :params => { :email => params[:email]})
    if user[0]
      #if user password is correct
      if user[0].pass == params[:pass]
        format_response(user[0])
      else
        raise Exceptions::NotMyFault.new(ERROR_INVALID_LOGIN)
      end
    else
      user = User.new(:email => params[:email], :pass => params[:pass])
      if user.save
        format_response(user)
      else
        raise Exceptions::NotMyFault.new(user.errors.full_messages[0])
      end
    end
  end

  private

  def format_response(user)
    key = ApiKey.find(:first, :conditions => { :user_id => user.id })

    response = {
      :user     => user.email,
      :api_key  => {
        :key      => key.key,
        :secret   => key.secret
      }
    }
    
    respond_to do |format|
      #format.html { render :xml   => response }
      format.xml  { render :xml   => response }
      format.json { render :json  => response }
    end
    #render :xml => response
  end
end
