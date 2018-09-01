class AddAssociationToExistingRecordsToCod2Game < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      UPDATE servers SET game_id = (SELECT id FROM games WHERE name = 'Call of Duty 2' LIMIT 1);
      UPDATE server_images SET game_id = (SELECT id FROM games WHERE name = 'Call of Duty 2' LIMIT 1);
    SQL
  end

  def self.down
    execute <<-SQL
      UPDATE servers SET game_id = NULL;
      UPDATE server_images SET game_id = NULL;
    SQL
  end
end
