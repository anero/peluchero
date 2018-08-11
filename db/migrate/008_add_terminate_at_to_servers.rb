class AddTerminateAtToServers < ActiveRecord::Migration
  def self.up
    add_column :servers, :terminate_at, :timestamp
  end

  def self.down
    remove_column :servers, :terminate_at
  end
end
