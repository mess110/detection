class Image < ActiveRecord::Base
  has_many :regions
  belongs_to :runner
  
  def complete!
    self.completed = true
    self.save!
  end

  def status
    if self.completed
      return "completed"
    elsif self.failed
      return "failed"
    else
      return "processing"
    end
  end
end
