class AddInstanceTypeAndSecurityGroupToServers < ActiveRecord::Migration
  def self.up
    add_column :servers, :instance_type, :string
    add_column :servers, :security_group, :string
  end

  def self.down
    remove_column :servers, :instance_type
    remove_column :servers, :security_group
  end
end
