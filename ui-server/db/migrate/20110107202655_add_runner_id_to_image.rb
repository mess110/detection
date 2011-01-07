class AddRunnerIdToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :runner_id, :integer
  end

  def self.down
    remove_column :images, :runner_id
  end
end
