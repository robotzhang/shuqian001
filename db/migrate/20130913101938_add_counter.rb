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

    # collection
    add_column :collections, :votes_count, :integer, :default => 0
    add_column :collections, :comments_count, :integer, :default => 0
    add_column :collections, :likes_count, :integer, :default => 0
    Collection.reset_column_information
    Collection.all.each do |collection|
      collection.votes_count = collection.votes.where(:vote => "up").count - collection.votes.where(:vote => "down").count
      collection.comments_count = collection.comments.count
      collection.likes_count = collection.likes.count

      collection.save(:validate => false)
    end

    # comment
    add_column :comments, :likes_count, :integer, :default => 0
    Comment.reset_column_information
    Comment.all.each do |comment|
      comment.likes_count = comment.likes.count

      comment.save(:validate => false)
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

    # users
    add_column :users, :comments_count, :integer, :default => 0
    User.reset_column_information
    User.all.each do |user|
      user.comments_count = user.comments.count

      user.save(:validate => false)
    end
  end

  def down
    remove_column :links, :votes_count
    remove_column :links, :comments_count
    remove_column :links, :likes_count

    remove_column :collections, :votes_count
    remove_column :collections, :comments_count
    remove_column :collections, :likes_count

    remove_column :comments, :likes_count

    remove_column :tags, :likes_count
    remove_column :tags, :taggings_count

    remove_column :users, :comments_count
  end
end
