class WebController < ApplicationController
  def index
  end
  
  def info
    @img = Image.new(:id => "42", :url => "http://url.to.my/image.jpg")
    @eta = 2
  end
  
  def thanks
  end
end
