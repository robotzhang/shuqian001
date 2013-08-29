class LinkGroup < ActiveRecord::Base
  attr_accessible :name, :content, :collection_id
  validates :name, presence: true, uniqueness: true
  validates :content, presence: true

  belongs_to :collection
end
