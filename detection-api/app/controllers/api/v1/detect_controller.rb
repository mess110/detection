class Api::V1::DetectController < Api::SecureApplicationController

  VALID_FORMAT = /^\d{1,7}$/

  def new
    #do security checks
    if (!params[:url] || params[:url].blank?)
      raise Exceptions::NotMyFault.new(ERROR_INVALID_URL)
    end

    #prepare the image
    image = Image.new
    cache_images = Image.find(:all, :params => { :resource => params[:url]})
    if cache_images.size == 0
      image.resource = params[:url]
      if !image.save
        raise Exceptions::NotMyFault.new(ERROR_INVALID_URL)
      end
    else
      image = cache_images[0]
    end

    #prepare the query
    q = Query.new
    q.api_key_id = session[:key_id].to_i
    q.image_id = image.id
    if !q.save
      raise Exceptions::NotMyFault.new(ERROR_SAVE_QUERY)
    end

    redirect_to :action => 'show', :params => { :url => image.id }
  end

  def show
    #do security checks
    if !(params[:url] && !params[:url].blank?)
      raise Exceptions::NotMyFault.new(ERROR_INVALID_URL)
    end

    #if it is a valid format (number)
    #since this is used to search in the model this will be checked
    if !(params[:url] =~ VALID_FORMAT)
      raise Exceptions::NotMyFault.new(ERROR_INVALID_URL)
    end

    #if the image does not exist
    begin
      img = Image.find(params[:url].to_i)
    rescue
      raise Exceptions::NotMyFault.new(ERROR_INVALID_URL)
    end

    if img.not_found
      raise Exceptions::NotMyFault.new(ERROR_INVALID_URL)
    end

    faces = Array.new
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
      :time           => Time.now,
      :faces          => faces
    }
    render :partial => "api/v1/detect.xml.builder", :locals => { :response => response }
  end
end
