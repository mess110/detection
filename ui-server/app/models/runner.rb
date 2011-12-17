class Runner < ActiveRecord::Base

  has_many :images

  scope :free, lambda {
    Runner.all.select{ |r| r if r.has_free_jobs }
  }

  def has_free_jobs
    max_jobs_per_minute > jobs_per_minute
  end

  private

  def jobs_per_minute
    Image.where('created_at > ? AND runner_id = ?', Time.now - 60, id).count
  end
end
