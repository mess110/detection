class Api::V2::DetectController < ApplicationController
  def new
    if request.get?
      render_api_error if params[:url].nil?
      @img = Image.create!(:url => params[:url])
      @eta = Scheduler.process_queue
      render :xml => "new.builder" && return
    elsif request.post?
    else
      render_api_error
    end
    # check if it was already detected
    # scheduel a runner for the job
    # make the runner do the job
  end

  def show
    if request.get?
    else
      render_api_error
    end
  end

end
