class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :vote #投票结果，good or bad

      t.string :votable_type
      t.integer :votable_id

      t.references :user
      t.timestamps
    end
  end
end
