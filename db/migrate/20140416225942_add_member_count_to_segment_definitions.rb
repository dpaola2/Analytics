class AddMemberCountToSegmentDefinitions < ActiveRecord::Migration
  def up
    add_column :segment_definitions, :member_count, :integer
  end

  def down
    remove_column :segment_definitions, :member_count
  end
end
