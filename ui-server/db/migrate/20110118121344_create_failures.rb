class CreateFailures < ActiveRecord::Migration
  def self.up
    create_table :failures do |t|
      t.integer :image_id
      t.string :message
      t.timestamps
    end
  end

  def self.down
    drop_table :failures
  end
end
