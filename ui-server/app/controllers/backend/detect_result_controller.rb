class Backend::DetectResultController < ApplicationController
  def report
    result = YAML::load(params[:result])
    render :text => "done"
  end
end
