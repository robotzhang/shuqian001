class Tagging < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :tag, :class_name => 'ActsAsTaggableOn::Tag', :counter_cache => true # 不加上class_name 那么counter_cache不会生效
  belongs_to :user, foreign_key: "tagger_id"
  belongs_to :taggable, :polymorphic => true

end
