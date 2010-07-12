class CreateApiKeys < ActiveRecord::Migration
  def self.up
    create_table :api_keys do |t|
      t.integer :user_id, :null => false
      t.string  :key,     :null => false, :limit => 10
      t.string  :secret,  :null => false, :limit => 10
      t.boolean :activated, :default => false
      t.boolean :block,   :default => false
      t.int     :limit,   :default => 50
      t.timestamps
    end
  end

  def self.down
    drop_table :api_keys
  end
end
