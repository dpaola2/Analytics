class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.datetime :timestamp
      t.string :path
      t.string :title
      t.string :utm_source
      t.string :utm_campaign
      t.string :utm_medium
      t.string :utm_name
      t.string :utm_content

      t.timestamps
    end
  end
end
