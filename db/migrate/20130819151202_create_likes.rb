class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :likable_type
      t.integer :likable_id
      t.references :user

      t.timestamps
    end
  end
end
