class Image < ActiveRecord::Base
  attr_accessible :name, :file, :imagable
  belongs_to :imagable, :polymorphic => true

  validates :file, presence: true

  mount_uploader :file, ImageUploader

end
