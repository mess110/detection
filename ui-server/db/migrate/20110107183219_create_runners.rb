class CreateRunners < ActiveRecord::Migration
  def self.up
    create_table :runners do |t|
      t.string :host
      t.integer :port
      t.integer :file_transfer_port
      t.timestamps
    end
  end

  def self.down
    drop_table :runners
  end
end
