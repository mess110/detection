class Runner < ActiveRecord::Base
  def details
    id.to_s
  end
end
