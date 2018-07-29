class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end

  def self.down
    drop_table :users
  end
end
