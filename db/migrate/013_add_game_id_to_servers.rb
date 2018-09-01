class AddGameIdToServers < ActiveRecord::Migration
  def self.up
    add_column :servers, :game_id, :integer
    add_index :servers, :game_id
  end

  def self.down
    remove_column :servers, :game_id
  end
end
