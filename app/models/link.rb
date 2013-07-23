class Link < ActiveRecord::Base
  attr_accessible :title, :url, :collection_id
  belongs_to :collection
  #validates :title, presence: true, uniqueness: { scope: :collection_id }
  validates :url, presence: true, uniqueness: { scope: :collection_id }
end
