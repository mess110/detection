class WebController < ApplicationController
  def index
    #@fln = JSON.parse(RestClient.get "http://github.com/api/v2/json/repos/show/mess110/detection") || 0
    @images = Image.find(:all, :conditions => ['completed = ? and karma >= ?', true, 1.0], :order => "created_at desc", :limit => 6)
  end
  
  def info
    @img = Image.new(:url => "http://url.to.my/image.jpg")
    @img.id = 42
    regions = [Region.new(:tlx => 10, :tly => 20, :brx => 70, :bry => 80),
               Region.new(:tlx => 60, :tly => 10, :brx => 80, :bry => 90)]
    @img.regions = regions
    @eta = 2
  end
  
  def thanks
  end
end
