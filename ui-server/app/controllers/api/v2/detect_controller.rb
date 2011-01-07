class Api::V2::DetectController < ApplicationController
  def new
    if request.post?
    elsif request.post?
    else
      render :partial => "error.builder"
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
