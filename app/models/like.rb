#coding=utf-8
class Like < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :likable, :polymorphic => true, :counter_cache => true
  belongs_to :user
  before_save do
    scope = Like.where(:user_id => self.user_id, :likable_type => self.likable_type, :likable_id => self.likable_id)
    if scope.count > 0
      self.errors.add(:like, '已经关注')
      false
    end
  end
end
