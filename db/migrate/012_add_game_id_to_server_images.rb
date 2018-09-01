class AddGameIdToServerImages < ActiveRecord::Migration
  def self.up
    add_column :server_images, :game_id, :integer
    add_index :server_images, :game_id
  end

  def self.down
    remove_column :server_images, :game_id
  end
end
