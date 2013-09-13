class AddCounter < ActiveRecord::Migration
  def up
    # link
    add_column :links, :votes_count, :integer, :default => 0
    add_column :links, :comments_count, :integer, :default => 0
    add_column :links, :likes_count, :integer, :default => 0
    Link.reset_column_information
    Link.all.each do |link|
      link.update_attributes(
          :votes_count => link.votes.where(:vote => "up").count - link.votes.where(:vote => "down").count,
          :comments_count => link.comments.count,
          :likes_count => link.likes.count
      )
    end

    # tags
    add_column :tags, :likes_count, :integer, :default => 0
    add_column :tags, :taggings_count, :integer, :default => 0
    Tag.reset_column_information
    Tag.all.each do |tag|
      tag.update_attributes(
          :likes_count => tag.likes.count,
          :taggings_count => tag.taggings.count
      )
    end
  end

  def down
    remove_column :links, :votes_count
    remove_column :links, :comment_count
    remove_column :links, :likes_count

    remove_column :tags, :likes_count
    remove_column :tags, :taggings_count
  end
end
