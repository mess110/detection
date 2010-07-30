class WebController < ApplicationController
  layout 'web'

  def index
    #render :text => 'asd'
    redirect_to :action => 'signup'
  end

  def signup
    #self.notice = 'The world of Warcraft is a pretty cool world'
  end

  def example
  end
end
