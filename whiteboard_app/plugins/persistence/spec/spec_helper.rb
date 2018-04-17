
require "persistence"

class CreateWhiteboardRecordsTable < ActiveRecord::Migration[4.2]
    def change
      create_table :whiteboard_records do |t|
        t.string :name
      end
    end
end

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "test.db")
ActiveRecord::Migrator.new(:up, [CreateWhiteboardRecordsTable.new]).migrate
# ActiveRecord::Migrator.up(File.join(__dir__, "..", "lib", "persistence", "migrations"))
# ActiveRecord::Migrator.new(:up, File.join(__dir__, "..", "lib", "persistence", "migrations")).migrate

RSpec.configure do |c|
  c.before do
    Persistence::WhiteboardRecord.delete_all
  end
end