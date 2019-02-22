class AddDescriptionToServerImages < ActiveRecord::Migration
  def self.up
    add_column :server_images, :description, :string
  end

  def self.down
    remove_column :server_images, :description
  end
end
