class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment
  attr_accessible :comment
  validates :comment, presence: true

  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  # 涉及到counter_cache会在数据库表中增加一个comments_count字段，所以必须单独指定关系
  # delegate :link, :to => :commentable, :counter_cache => true

  has_many :likes, {:as => :likable, :dependent => :destroy}

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
end
