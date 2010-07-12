# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  ERROR_NO_FACES_FOUND      = "no faces found"
  ERROR_INVALID_URL         = "invalid url"
  ERROR_SAVE_IMAGE          = "could not save image"
  ERROR_INVALID_IMAGE       = "image is invalid"
  ERROR_UNKOWN_IMAGE_FORMAT = "unkown image format"
  ERROR_SAVE_REGION         = "could not save region. you are prob hacking! damn you!!"
  ERROR_INVALID_LOGIN       = "could not login"
  ERROR_SAVE_USER           = "error saving user"

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private

  # is this the correct way to log errors?
  def rescuee_action(e)
    description = e.to_s
    backtrace = e.backtrace.join("\n")
    error = Error.new(:description => description, :backtrace => backtrace,
                    :api_key_id  => session[:key_id], :params => params)
    error.save

    err = {
      :time         => Time.now,
      :description  => description,
      :params       => params,
    }
    render :xml  => err
  end

end
