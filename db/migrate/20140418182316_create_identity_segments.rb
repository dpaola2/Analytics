class CreateIdentitySegments < ActiveRecord::Migration
  def change
    create_table :identity_segments do |t|
      t.integer :identity_id
      t.integer :segment_definition_id
      t.datetime :created_at
      t.datetime :left_at

      t.timestamps
    end
  end
end
