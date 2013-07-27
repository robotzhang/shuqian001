class Collection < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :title, :description
  validates :title, presence: true, uniqueness: true
  has_many :links
  #has_many :comments, :through => 'commentable_type'
  belongs_to :user
end
