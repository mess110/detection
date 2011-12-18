class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_api_error(error_code, error_description)
    render :partial => "api/v2/detect/error", :locals => { :params => { :error_code => error_code, :error_description => error_description }}
  end
end
