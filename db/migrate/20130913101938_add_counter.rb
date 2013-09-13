class AddCounter < ActiveRecord::Migration
  def up
    # link
    add_column :links, :votes_count, :integer, :default => 0
    add_column :links, :comments_count, :integer, :default => 0
    add_column :links, :likes_count, :integer, :default => 0
    Link.reset_column_information
    Link.all.each do |link|
      link.votes_count = link.votes.where(:vote => "up").count - link.votes.where(:vote => "down").count
      link.comments_count = link.comments.count
      link.likes_count = link.likes.count

      link.save(:validate => false)
    end

    # tags
    add_column :tags, :likes_count, :integer, :default => 0
    add_column :tags, :taggings_count, :integer, :default => 0
    Tag.reset_column_information
    Tag.all.each do |tag|
      tag.likes_count = tag.likes.count
      tag.taggings_count = tag.taggings.count

      tag.save(:validate => false)
    end
  end

  def down
    remove_column :links, :votes_count
    remove_column :links, :comments_count
    remove_column :links, :likes_count

    remove_column :tags, :likes_count
    remove_column :tags, :taggings_count
  end
end
