class DropSessionIdFromIdentity < ActiveRecord::Migration
  def up
    remove_column :identities, :session_id
  end

  def down
    add_column :identities, :session_id, :string
  end
end
