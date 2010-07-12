class CreateErrors < ActiveRecord::Migration
  def self.up
    create_table :errors do |t|
      t.integer :api_key_id
      t.string  :description
      t.string  :params
      t.text    :backtrace
      t.boolean :handled, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :errors
  end
end
