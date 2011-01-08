class WebController < ApplicationController
  def index
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
