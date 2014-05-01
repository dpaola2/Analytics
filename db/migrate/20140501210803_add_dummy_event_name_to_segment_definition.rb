class AddDummyEventNameToSegmentDefinition < ActiveRecord::Migration
  def change
    add_column :segment_definitions, :event_name, :string
  end
end
