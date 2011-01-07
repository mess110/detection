class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.integer :image_id
      t.integer :tlx
      t.integer :tly
      t.integer :brx
      t.integer :bry
      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
