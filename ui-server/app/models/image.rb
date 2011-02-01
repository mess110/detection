class Image < ActiveRecord::Base

  INVALID_PROTOCOL = "invalid_protocol"
  INVALID_IMAGE_FORMAT = "invalid_image_fornat"

  STATUS_COMPLETED  = "completed"
  STATUS_FAILED     = "failed"
  STATUS_PROCESSING = "processing"

  has_many :regions
  has_many :failures
  belongs_to :runner, :counter_cache => true

  validates_format_of :url,
                :with => URI::regexp(%w(http https)), :message => INVALID_PROTOCOL
  validates_format_of :url,
                :with => /.*\.(jpg|jpeg)$/i, :message => INVALID_IMAGE_FORMAT

  scope :samples, lambda {
    where('completed = ? and karma >= ?', true, 1.0).order("images.created_at DESC").limit(6)
  }

  def complete!
    self.completed = true
    self.save!
  end

  def failed?
    self.failures.count != 0
  end

  def status
    if completed?
      return STATUS_COMPLETED
    elsif failed?
      return STATUS_FAILED
    else
      return STATUS_PROCESSING
    end
  end
end
