class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.integer :api_key_id,    :null => false
      t.integer :image_id,      :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
