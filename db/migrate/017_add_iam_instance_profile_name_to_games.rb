class AddIamInstanceProfileNameToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :iam_instance_profile_name, :string
  end

  def self.down
    remove_column :games, :iam_instance_profile_name
  end
end
