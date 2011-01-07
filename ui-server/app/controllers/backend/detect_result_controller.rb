class Backend::DetectResultController < ApplicationController
  def report
    image_id = params[:image_id]
    regions = YAML::load(params[:regions])
    regions.each do |r|
      Region.create!(:image_id => image_id, :tlx => r[:tlx], :tly => r[:tly], :brx => r[:brx], :bry => r[:bry])
    end
    render :text => "200"
  end
end
