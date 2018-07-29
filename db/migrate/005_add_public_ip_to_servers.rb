class AddPublicIpToServers < ActiveRecord::Migration
  def self.up
    add_column :servers, :public_ip, :string
  end

  def self.down
    remove_column :servers, :public_ip
  end
end
