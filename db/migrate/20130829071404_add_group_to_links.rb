class AddGroupToLinks < ActiveRecord::Migration
  def change
    add_column :links, :link_group_id, :integer
  end
end
