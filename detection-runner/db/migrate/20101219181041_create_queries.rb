class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
