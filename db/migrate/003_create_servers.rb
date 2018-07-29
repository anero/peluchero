class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.string :instance_id, null: false
      t.string :status
      t.references :server_image, null: false

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :servers
  end
end
