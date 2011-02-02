#http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg
class Api::V2::DetectController < ApplicationController

  protect_from_forgery :except => :new

  def new
    if request.get?
      if params[:url].nil?
        render_api_error('invalid_url', 'url parameter required') and return
      end

      if @img = Image.find_by_url(params[:url])
        if @img.failed?
          render_api_error('invalid_image', @img.failures.last.message) and return
        end
        
        @eta = 0
      else
        @img = Image.new(:url => params[:url])
        
         if !@img.valid?
          render_api_error(@img.errors[:url].first, @img.errors[:url].first) and return
        end
        
        @eta = Scheduler.process_image @img
        if @eta == Scheduler::RUNNERS_FULL
          render_api_error('over_capacity', "Our runners are full. Please try again later.") and return
        end
      end

      render :partial => "new" and return
    elsif request.post?
      # TODO: remove this when implemented
      render_api_error('invalid_request', 'not yet implemented') and return
      
      if params[:file].nil?
        render_api_error('invalid_url', 'file parameter required') and return
      end
      
      filename =  params[:file].original_filename
      path = File.join("public/data", filename)
      file_content = params[:file].read
      File.open(path, "wb") { |f| f.write(file_content) }
      render_api_error('invalid_request', "console output") and return
    else
      render_api_error('invalid_request', 'put and delete now allowed') and return
    end
  end

end
