#coding=utf-8
class Vote < ActiveRecord::Base
  attr_accessible :vote
  belongs_to :votable, :polymorphic => true, :counter_cache => true

  before_save do
    scope = Vote.where(:user_id => self.user_id, :votable_type => self.votable_type, :votable_id => self.votable_id)
    if scope.count > 0
      self.errors.add(:vote, '已经投票')
      false
    end
  end
end
