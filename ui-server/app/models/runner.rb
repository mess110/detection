class Runner < ActiveRecord::Base

  has_many :images
  
  def self.assign img
    r = Runner.first(:order => 'images_count asc')
    img.runner_id = r.id
    img.save!
    return r
  end

  def details
    id.to_s
  end
end
