class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def render_api_error
    render :partial => "api/v2/detect/error.builder"
  end
end
