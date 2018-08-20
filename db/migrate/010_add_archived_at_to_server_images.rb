class AddArchivedAtToServerImages < ActiveRecord::Migration
  def self.up
    add_column :server_images, :archived_at, :datetime
  end

  def self.down
    remove_column :server_images, :archived_at
  end
end
