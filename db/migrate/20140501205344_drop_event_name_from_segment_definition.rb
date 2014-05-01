class DropEventNameFromSegmentDefinition < ActiveRecord::Migration
  def change
    remove_column :segment_definitions, :event_name
  end
end
