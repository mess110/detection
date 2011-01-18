class Backend::DetectResultController < ApplicationController
  def report
    image_id = params[:image_id]
    if params[:error_message].present?
      #puts params[:error_message]
      Image.find(image_id).failed!
    else
      regions = YAML::load(params[:regions])
      regions.each do |r|
        Region.create!(:image_id => image_id, :tlx => r[:tlx], :tly => r[:tly], :brx => r[:brx], :bry => r[:bry])
      end
      Image.find(image_id).complete!
    end
    render :text => "200"
  end
end
