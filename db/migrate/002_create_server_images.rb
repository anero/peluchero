class CreateServerImages < ActiveRecord::Migration
  def self.up
    create_table :server_images do |t|
      t.string :ami_id, null: false
      t.string :name

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :server_images
  end
end
