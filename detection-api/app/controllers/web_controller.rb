class WebController < ApplicationController
  layout 'web'

  def index
    redirect_to :action => 'signup'
  end

  def signup
    #self.notice = 'The world of Warcraft is a pretty cool world'
  end

  def example
  end

  def thanks
  end
end
