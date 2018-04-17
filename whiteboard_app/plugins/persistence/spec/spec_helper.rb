
require "persistence"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "test.db")
ActiveRecord::MigrationContext.new(File.join(__dir__, "..", "lib", "persistence", "migrations")).migrate

RSpec.configure do |c|
  c.before do
    Persistence::WhiteboardRecord.delete_all
  end
end