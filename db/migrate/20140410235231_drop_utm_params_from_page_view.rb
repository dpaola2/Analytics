class DropUtmParamsFromPageView < ActiveRecord::Migration
  def up
    remove_column :page_views, :utm_source
    remove_column :page_views, :utm_campaign
    remove_column :page_views, :utm_medium
    remove_column :page_views, :utm_name
    remove_column :page_views, :utm_content
  end
  def down
    add_column :page_views, :utm_content, :string
    add_column :page_views, :utm_name, :string
    add_column :page_views, :utm_medium, :string
    add_column :page_views, :utm_campaign, :string
    add_column :page_views, :utm_source, :string
  end
end
