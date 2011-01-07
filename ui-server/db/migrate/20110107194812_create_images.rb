class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :url
      t.boolean :completed, :default => false
      t.boolean :failed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
