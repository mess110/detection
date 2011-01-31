class Backend::DetectResultController < ApplicationController
  USER_ID, PASSWORD = "changeme", "changeme"
 
  # Require authentication only for edit and delete operation
  before_filter :authenticate, :only => [ :report ]

  def report
    image_id = params[:image_id]
    if params[:error_message].present?
      img = Image.find(image_id)
      img.failures << Failure.create!(:message => params[:error_message])
    else
      regions = YAML::load(params[:regions])
      regions.each do |r|
        Region.create!(:image_id => image_id, :tlx => r[:tlx], :tly => r[:tly], :brx => r[:brx], :bry => r[:bry])
      end
      Image.find(image_id).complete!
    end
    render :text => "200"
  end
  
  private

  def authenticate
    authenticate_or_request_with_http_basic do |id, password| 
      id == USER_ID && password == PASSWORD
    end
  end
end
