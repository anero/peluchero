class CreateCod2Game < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      INSERT INTO games(name, tag, preferred_security_group, created_at, updated_at) VALUES('Call of Duty 2', 'cod2', 'sg-a1d52cd8', current_timestamp, current_timestamp);
    SQL
  end

  def self.down
    execute <<-SQL
      DELETE FROM games WHERE name = 'Call of Duty 2'
    SQL
  end
end
