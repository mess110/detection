class Api::V2::DetectController < ApplicationController
  def new
    if request.get?
      params[:url]
    elsif request.post?
    else
    end
    # check if it was already detected
    # scheduel a runner for the job
    # make the runner do the job
  end

  def show
    if request.get?
    else
    end
  end

end
