class WebController < ApplicationController
  DEMO_URL = "http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg"

  def index
    #@fln = JSON.parse(RestClient.get "http://github.com/api/v2/json/repos/show/mess110/detection") || 0
    @images = Image.samples
  end

  def demo
    @demo_url = DEMO_URL
    if !params[:demo_url].nil?
      @demo_url = params[:demo_url]
    end
    @images = Image.samples
  end

  def info
    @img = Image.new(:url => "http://url.to.my/image.jpg")
    @img.id = 42
    regions = [Region.new(:tlx => 10, :tly => 20, :brx => 70, :bry => 80),
               Region.new(:tlx => 60, :tly => 10, :brx => 80, :bry => 90)]
    @img.regions = regions
    @eta = 2
  end

  def solutions
  end
end
