class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :session_id
      t.string :userid
      t.string :email
      t.string :username
      t.datetime :created
      t.integer :event_id

      t.timestamps
    end
  end
end
