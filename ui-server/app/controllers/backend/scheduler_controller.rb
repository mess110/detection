class Backend::SchedulerController < ApplicationController
  def register
    Runner.create!({:host => params[:host], :port => params[:port],
                      :file_transfer_port => params[:file_transfer_port]})
    render :text => "200"
  end
end
