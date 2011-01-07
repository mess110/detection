class Runner < ActiveRecord::Base

  has_many :images

  def details
    id.to_s
  end
end
