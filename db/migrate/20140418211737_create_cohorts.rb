class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :name
      t.string :time_bucket
      t.integer :segment_definition_id

      t.timestamps
    end
  end
end
