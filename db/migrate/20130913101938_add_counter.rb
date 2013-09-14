class AddCounter < ActiveRecord::Migration
  def up
    ActiveRecord::Base.logger=Logger.new(STDOUT)
    # link
    add_column :links, :votes_count, :integer, :default => 0
    add_column :links, :comments_count, :integer, :default => 0
    add_column :links, :likes_count, :integer, :default => 0
    Link.reset_column_information
    Link.all.each do |link|
      votes_count = link.votes.where(:vote => "up").count - link.votes.where(:vote => "down").count
      link.update_column :votes_count, votes_count
      link.update_column :comments_count, link.comments.count
      link.update_column :likes_count, link.likes.count
    end

    # collection
    add_column :collections, :votes_count, :integer, :default => 0
    add_column :collections, :comments_count, :integer, :default => 0
    add_column :collections, :likes_count, :integer, :default => 0
    Collection.reset_column_information
    Collection.all.each do |collection|
      votes_count = collection.votes.where(:vote => "up").count - collection.votes.where(:vote => "down").count

      collection.update_column :votes_count, votes_count
      collection.update_column :comments_count, collection.comments.count
      collection.update_column :likes_count, collection.likes.count
    end

    # comment
    add_column :comments, :likes_count, :integer, :default => 0
    Comment.reset_column_information
    Comment.all.each do |comment|
      comment.update_column :likes_count, comment.likes.count
    end

    # tags
    add_column :tags, :likes_count, :integer, :default => 0
    add_column :tags, :taggings_count, :integer, :default => 0
    Tag.reset_column_information
    Tag.all.each do |tag|
      tag.update_column :likes_count, tag.likes.count
      tag.update_column :taggings_count, tag.taggings.count
    end

    # users
    add_column :users, :comments_count, :integer, :default => 0
    User.reset_column_information
    User.all.each do |user|
      user.update_column :comments_count, user.comments.count
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
