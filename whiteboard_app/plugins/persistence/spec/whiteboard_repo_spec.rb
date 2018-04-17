require "whiteboard/contracts/whiteboard_repo_contract"

module Persistence
    require "active_record"
    class WhiteboardRecord < ActiveRecord::Base
    end

    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "test.db")

    class CreateWhiteboardRecordsTable < ActiveRecord::Migration[4.2]
        def change
          create_table :whiteboard_records do |t|
            t.string :name
          end
        end
    end

    ActiveRecord::Migrator.new(:up, [CreateWhiteboardRecordsTable.new]).migrate

    class WhiteboardRepo
        def save(whiteboard)
            record = WhiteboardRecord.new(name: whiteboard.name)
            record.save!
            whiteboard.id = record.id
        end

        def find_by_name(name)
            record = WhiteboardRecord.find_by_name(name)

            if record
              Whiteboard.new(name: name, id: record.id)
            else
              nil
            end
        end
    end
end

whiteboard_repo_contract Persistence::WhiteboardRepo

RSpec.configure do |c|
    c.before do
      Persistence::WhiteboardRecord.delete_all
    end
end