class DetectionController < SecureApplicationController

  #imba regular expression that checks if URL is valid. performs checks
  VALID_URL = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/)+(.*\.(png|jpg)$)/ix
  VALID_FORMAT = /^\d{1,7}$/

  def new
    #do security checks
    if !(params[:url] && !params[:url].blank?)
      raise ERROR_INVALID_URL
    end

    #if it is a valid format
    if !(params[:url] =~ VALID_URL)
      raise ERROR_INVALID_URL
    end

    #prepare the image
    image = Image.new
    cache_images = Image.find(:all, :params => { :resource => params[:url]})
    if cache_images.size == 0
      image.resource = params[:url]
      image.save
    else
      image = cache_images[0]
    end

    #prepare the query
    q = Query.new
    q.api_key_id = session[:key_id].to_i
    q.image_id = image.id
    q.save

    redirect_to :action => 'show', :params => { :url => image.id }
  end

  def show
    #do security checks
    if !(params[:url] && !params[:url].blank?)
      raise ERROR_INVALID_URL
    end

    #if it is a valid format
    if !(params[:url] =~ VALID_FORMAT)
      raise ERROR_INVALID_URL
    end

    #if the image does not exist
    Image.find(params[:url].to_i) rescue raise ERROR_INVALID_URL

    foo = Array.new
    regions = Region.find(:all, :params => { :image_id => params[:url]})
    regions.each do |region|
      foo << {
          :top_left_x       => region.top_left_x,
          :top_left_y       => region.top_left_y,
          :bottom_right_x   => region.bottom_right_x,
          :bottom_right_y   => region.bottom_right_y
        }
    end

    @response = {
      :id             => params[:url].to_i,
      :time           => Time.now,
      :faces          => foo
    }

    render :xml => @response
  end
end
