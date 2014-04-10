class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :blob
      t.timestamps
    end
  end
end
