class CreateSegmentDefinitions < ActiveRecord::Migration
  def change
    create_table :segment_definitions do |t|
      t.string :name
      t.string :event_name
      t.integer :user_id

      t.timestamps
    end
  end
end
