class AddServerIamRoleToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :server_iam_role, :string
  end

  def self.down
    remove_column :games, :server_iam_role
  end
end
