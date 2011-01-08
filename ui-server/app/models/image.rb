class Image < ActiveRecord::Base
  has_many :regions
  belongs_to :runner

  STATUS_COMPLETED  = "completed"
  STATUS_FAILED     = "failed"
  STATUS_PROCESSING = "processing"

  def complete!
    self.completed = true
    self.save!
  end

  def status
    if self.completed
      return STATUS_COMPLETED
    elsif self.failed
      return STATUS_FAILED
    else
      return STATUS_PROCESSING
    end
  end
end
