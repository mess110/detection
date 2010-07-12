class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :email,   :null => false, :limit => 32
      t.string  :pass,   :null => false, :limit => 32
      t.int     :api_key_id,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
