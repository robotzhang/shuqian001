class AddViews < ActiveRecord::Migration
  def up
    add_column :users, :views, :integer, :default => 0
    add_column :collections, :views, :integer, :default => 0
    add_column :links, :views, :integer, :default => 0
    add_column :tags, :views, :integer, :default => 0
  end

  def down
    remove_column :users, :views
    remove_column :collections, :views
    remove_column :links, :views
    remove_column :tags, :views
  end
end
