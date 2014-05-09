class AddJsonToEvents < ActiveRecord::Migration
  def up
    add_column :events, :json_properties, :json
  end

  def down
    remove_column :events, :json_properties
  end
end
