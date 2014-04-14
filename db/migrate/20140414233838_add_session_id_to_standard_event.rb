class AddSessionIdToStandardEvent < ActiveRecord::Migration
  def up
    add_column :standard_events, :session_id, :string
  end

  def down
    remove_column :standard_events, :session_id
  end
end
