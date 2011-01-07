class Image < ActiveRecord::Base
  has_many :regions
  belongs_to :runner
  
  def complete!
    self.completed = true
    self.save!
  end
end
