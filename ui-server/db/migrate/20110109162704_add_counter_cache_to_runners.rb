class AddCounterCacheToRunners < ActiveRecord::Migration
  def self.up
    add_column :runners, :images_count, :integer, :default => 0

    Runner.reset_column_information
    Runner.all.each do |r|
      Runner.update_counters r.id, :images_count => r.images.length
    end
  end

  def self.down
    remove_column :runners, :images_count
  end
end
