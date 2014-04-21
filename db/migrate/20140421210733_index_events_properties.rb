class IndexEventsProperties < ActiveRecord::Migration
  def up
    execute "CREATE INDEX events_properties_index on events USING GIN(properties)"
  end

  def down
    execute "DROP INDEX events_properties_index"
  end
end
