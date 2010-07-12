class AuthController < ApplicationController
  def register
    #do a lot of security checks
    user = User.find(:all, :params => { :email => params[:email]})
    if user[0]
      #if user password is correct
      if user[0].pass == params[:pass]
        response = say_what(user[0])
        render :xml => response
      else
        raise ERROR_INVALID_LOGIN
      end
    else
      user = User.new(:email => params[:email], :pass => params[:pass])
      if user.save
        response = say_what(user)
        render :xml => response
      else
        raise ERROR_SAVE_USER
      end
    end
  end

  private

  def say_what(user)
    key = ApiKey.find(:first, :conditions => { :user_id => user.id })

    response = {
      :user => user.email,
      :api_key => {
        :key  => key.key,
        :secret => key.secret
      }
    }
  end
end
