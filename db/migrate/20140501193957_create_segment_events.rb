class CreateSegmentEvents < ActiveRecord::Migration
  def change
    create_table :segment_events do |t|
      t.integer :segment_definition_id
      t.string :event_name

      t.timestamps
    end
  end
end
