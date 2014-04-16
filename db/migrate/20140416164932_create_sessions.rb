class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :unique_id
      t.integer :identity_id

      t.timestamps
    end
  end
end
