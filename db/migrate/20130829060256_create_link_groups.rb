class CreateLinkGroups < ActiveRecord::Migration
  def change
    create_table :link_groups do |t|
      t.string :name
      t.text :content

      t.references :collection

      t.timestamps
    end
  end
end
