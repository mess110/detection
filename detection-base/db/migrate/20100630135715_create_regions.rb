class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.integer :image_id, :null => false
      t.integer :top_left_x, :null => false
      t.integer :top_left_y, :null => false
      t.integer :bottom_right_x, :null => false
      t.integer :bottom_right_y, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
