class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment
  attr_accessible :comment
  validates :comment, presence: true

  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  has_many :likes, {:as => :likable, :dependent => :destroy}

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
end
