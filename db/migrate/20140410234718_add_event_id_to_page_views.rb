class AddEventIdToPageViews < ActiveRecord::Migration
  def up
    add_column :page_views, :event_id, :integer
  end

  def down
    remove_column :page_views, :event_id
  end
end
