# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  ERROR_INVALID_URL         = "invalid url"
  ERROR_SAVE_IMAGE          = "could not save image"
  ERROR_INVALID_IMAGE       = "image is invalid"
  ERROR_UNKOWN_IMAGE_FORMAT = "unkown image format"
  ERROR_SAVE_REGION         = "could not save region. you are prob hacking! damn you!!"
  ERROR_INVALID_LOGIN       = "invalid login"
  ERROR_INVALID_API         = "invalid api key and secret combination"
  ERROR_SAVE_USER           = "error saving user"
  ERROR_REQUIRE_EMAIL       = "email parameter required"
  ERROR_REQUIRE_PASS        = "pass parameter required"
  ERROR_SAVE_QUERY          = "error saving query"

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # rescue from a certain exceptions spares me from if else end hell
  rescue_from Exceptions::NotMyFault, :with => :rescue_user_error

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def offer_response response
    respond_to do |format|
      format.xml  { render :xml   => response }
      format.json { render :json  => response }
    end    
  end

  private

  # now this is the right way to log errors
  def rescue_user_error(e)
    description = e.message
    #backtrace = e.backtrace.join("\n")
    error = Error.new(:description => description, :backtrace => '',
                      :api_key_id  => session[:key_id], :params => params).save
    err = {
      :time         => Time.now,
      :description  => description,
    }

    respond_to do |format|
      format.html { render :xml   => err }
      format.xml  { render :xml   => err }
      format.json { render :json  => err }
    end
  end
end
