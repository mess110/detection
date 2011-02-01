class AddJobsPerMinute < ActiveRecord::Migration
  def self.up
    add_column :runners, :max_jobs_per_minute, :integer, :default => 20, :null => false
  end

  def self.down
    remove_column :runners, :max_jobs_per_minute
  end
end
