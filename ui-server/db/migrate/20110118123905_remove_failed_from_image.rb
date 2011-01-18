class RemoveFailedFromImage < ActiveRecord::Migration
  def self.up
    remove_column :images, :failed
  end

  def self.down
    add_column :images, :failed, :boolean, :default => false
  end
end
