class WebController < ApplicationController
  layout 'web'

  def index
    redirect_to :action => :user
  end

  def signup
    if session[:user_id]
      redirect_to :action => :user
    else
      if !notice
        self.notice = "Welcome to the FREE face detection API!! <br /><b>Login and Register with the form below!</b> (we do not care about or need any extra information and belive you don't have to give it away to use any type of service!)"
      end
    end
  end
  
  def user
    if !session[:user_id]
      redirect_to :action => 'signup'
    else
      if !notice
        self.notice = "Check out the INFO page for examples"
      end
      @user = User.find(session[:user_id].to_i)
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :action => :signup
  end

  def example
    @auth_response = {
      :email  => "your-email@is-here.com",
      :key    => "THIS_IS_YOUR_KEY",
      :secret => "THIS_IS_YOUR_SECRET"  
    }
    faces = [{:top_left_x => 10, :top_left_y => 20, :bottom_right_x => 70, :bottom_right_y => 80},
             {:top_left_x => 60, :top_left_y => 10, :bottom_right_x => 80, :bottom_right_y => 90}]
    @detect_response = {
      :query_id => 10,
      :faces    => faces
    }
  end

  def thanks
  end

  # there is no reason why this method should be here. I think there was one
  # in the past but it was probably stupid. Use the API for registring and
  # handeling everything. don't duplicate code!!
  def auth
    user = User.find(:all, :params => { :email => params[:email]})
    if user[0]
      #if user password is correct
      if user[0].password?(params[:pass])
        session[:user_id] = user[0].id.to_i
        self.notice = 'Login successful'
        redirect_to :action => :user
      else
        self.notice = 'Wrong user/pass combination'
        redirect_to :action => :signup
      end
    else
      user = User.new(:email => params[:email], :pass => params[:pass])
      if user.save
        self.notice = 'New user registered'
          session[:user_id] = user.id.to_i
        redirect_to :action => :user
      else
        self.notice = user.errors.full_messages[0]
        redirect_to :action => 'signup'
     end
    end
  end
end
