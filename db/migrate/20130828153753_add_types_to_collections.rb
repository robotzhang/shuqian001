class AddTypesToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :types, :string, :default => "share"
  end
end
