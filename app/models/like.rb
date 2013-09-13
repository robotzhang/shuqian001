#coding=utf-8
class Like < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :likable, :polymorphic => true
  belongs_to :link, :foreign_key => :commentable_id, :class_name => "Link", :counter_cache => true
  belongs_to :tag, :foreign_key => :commentable_id, :class_name => "Tag", :counter_cache => true
  belongs_to :user
  before_save do
    scope = Like.where(:user_id => self.user_id, :likable_type => self.likable_type, :likable_id => self.likable_id)
    if scope.count > 0
      self.errors.add(:like, '已经关注')
      false
    end
  end
end
