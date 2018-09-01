class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name, unique: true
      t.string :preferred_security_group
      t.string :tag
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
