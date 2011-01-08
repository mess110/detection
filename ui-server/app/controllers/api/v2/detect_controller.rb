class Api::V2::DetectController < ApplicationController
  def new
    if request.get?
      if params[:url].nil?
        render_api_error and return
      end
      
      @img = Image.create!(:url => params[:url])
      
      if @img.errors.count > 0
        render_api_error and return
      end
      
      @eta = Scheduler.process_queue @img.id
      render :partial => "new" and return
    elsif request.post?
      # uploading files will be handled with post request
      render_api_error and return
    else
      render_api_error and return
    end
  end

  def show
    if request.get?
      render_api_error and return
    else
      render_api_error and return
    end
  end

end
