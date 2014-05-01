class AddComputeSecondsToSegmentDefinition < ActiveRecord::Migration
  def up
    add_column :segment_definitions, :compute_seconds, :float
  end
  def down
    remove_column :segment_definitions, :compute_seconds
  end
end
