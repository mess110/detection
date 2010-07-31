class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string  :resource,  :null => false, :limit => 400
      t.boolean :not_found,  :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
