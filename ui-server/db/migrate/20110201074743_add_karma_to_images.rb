class AddKarmaToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :karma, :float, :default => 1.0, :null => false
  end

  def self.down
    remove_column :images, :karma
  end
end
