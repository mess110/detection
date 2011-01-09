#http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg
class Api::V2::DetectController < ApplicationController
  def new
    if request.get?
      if params[:url].nil?
        render_api_error and return
      end

      if @img = Image.find_by_url(params[:url])
        @eta = 0
      else
        @img = Image.new(:url => params[:url])
        
        if !@img.valid?
          render_api_error and return
        end
        
        @eta = Scheduler.process_image @img
      end

      if @img.completed?
        render :partial => "show" and return
      else
        render :partial => "new" and return
      end
    elsif request.post?
      # uploading files will be handled with post request
      render_api_error and return
    else
      render_api_error and return
    end
  end

end
