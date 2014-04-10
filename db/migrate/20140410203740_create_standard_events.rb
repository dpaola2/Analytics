class CreateStandardEvents < ActiveRecord::Migration
  def change
    create_table :standard_events do |t|
      t.string :name
      t.text :params
      t.integer :event_id
      t.datetime :timestamp

      t.timestamps
    end
  end
end
