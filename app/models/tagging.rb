class Tagging < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :tag, :counter_cache => true
  belongs_to :user, foreign_key: "tagger_id"
  belongs_to :taggable, :polymorphic => true

end
