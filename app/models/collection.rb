#coding=utf-8
class Collection < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
  acts_as_taggable_on :tags

  attr_accessible :title, :description, :types, :tag_list
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true#, uniqueness: true

  has_many :links, :order => 'created_at DESC'
  has_many :link_groups, :order => 'created_at DESC'
  has_many :likes, {:as => :likable, :dependent => :destroy}
  #has_many :comments, :through => 'commentable_type'
  belongs_to :user

  before_save :set_tag_owner
  before_save do
    self.types = self.types != "ask" ? "share" : "ask"
  end

  # 设置打标签的用户
  def set_tag_owner
    # Set the owner of some tags based on the current tag_list
    set_owner_tag_list_on(User.find(self.user_id), :tags, self.tag_list)
    # Clear the list so we don't get duplicate taggings
    self.tag_list = nil # 如果不这样会出现重复标签
  end

  # 系统标签
  def self.sys_tags
    ["技术", "电影", "音乐", "读书", "游戏", "小说", "设计", "博文", "软件", "学习", "创意", "互联网", "品牌"]
  end

  def all_links
    links = self.links.sort_by{|link|  link.votes.where(vote: 'down').size - link.votes.where(vote: 'up').size }
    hash = Hash.new
    links.each do |link|
      hash[link.link_group] = [] if hash[link.link_group].blank?
      hash[link.link_group] << link
    end

    hash
  end
end
