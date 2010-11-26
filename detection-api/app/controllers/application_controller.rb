# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  ERROR_INVALID_URL         = "invalid url"
  ERROR_INVALID_LOGIN       = "invalid login"
  ERROR_INVALID_API         = "invalid api key and secret combination"
  ERROR_REQUIRE_EMAIL       = "email parameter required"
  ERROR_REQUIRE_PASS        = "pass parameter required"
  ERROR_SAVE_QUERY          = "error saving query"

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private
  
  def render_error(message)
    render :partial => "api/v1/error.xml.builder", :locals => { :message => message }
    # TODO improve logging errors. move each log where the error is raised
    # TODO error maybe not a good name
    # TODO provide more details
    logger.info "INFO: " + message
  end
end
