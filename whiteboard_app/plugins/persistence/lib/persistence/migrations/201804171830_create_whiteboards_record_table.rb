class CreateWhiteboardsRecordTable < ActiveRecord::Migration[5.2]
    def change
      create_table :whiteboard_records do |t|
        t.string :name
      end
    end
end