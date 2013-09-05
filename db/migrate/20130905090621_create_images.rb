class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :file

      t.string :imagable_type
      t.integer :imagable_id

      t.references :user

      t.timestamps
    end

    add_index :images, :imagable_type
    add_index :images, :imagable_id
    add_index :images, :user_id
  end
end
