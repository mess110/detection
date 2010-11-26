class Api::V1::DetectController < Api::SecureApplicationController

  VALID_FORMAT = /^\d{1,7}$/

  def new
    if (!params[:url] || params[:url].blank?)
      render_error(ERROR_INVALID_URL) and return
    end

    image = Image.find(:first, :params => { :resource => params[:url]})
    if image.nil?
      image = Image.create(:resource => params[:url])
    end

    Query.create(:api_key_id => session[:key_id].to_i, :image_id => image.id)
    redirect_to :action => 'show', :params => { :url => image.id }
  end

  def show
    if !(params[:url] && !params[:url].blank?) || !(params[:url] =~ VALID_FORMAT)
      render_error(ERROR_INVALID_URL) and return
    end

    begin
      img = Image.find(params[:url].to_i)
    rescue
      render_error(ERROR_INVALID_URL) and return
    end

    if img.not_found
      render_error(ERROR_INVALID_URL) and return
    end

    faces = []
    img.regions.each do |region|
      faces << {
          :top_left_x       => region.top_left_x,
          :top_left_y       => region.top_left_y,
          :bottom_right_x   => region.bottom_right_x,
          :bottom_right_y   => region.bottom_right_y
      }
    end

    response = {
      :query_id       => params[:url].to_i,
      :faces          => faces
    }
    render :partial => "api/v1/detect.xml.builder", :locals => { :response => response }
  end
end
