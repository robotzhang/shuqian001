class Collection < ActiveRecord::Base
  attr_accessible :title, :description
  validates :title, presence: true, uniqueness: true
  has_many :links
end
