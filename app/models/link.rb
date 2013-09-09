#coding=utf-8
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'timeout'
require 'open-uri'

class Link < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
  acts_as_taggable_on :tags

  attr_accessible :title, :url, :description, :collection_id, :link_group_id, :tag_list
  belongs_to :collection
  belongs_to :user
  belongs_to :link_group
  has_many :votes, {:as => :votable, :dependent => :destroy}
  has_many :likes, {:as => :likable, :dependent => :destroy}
  has_many :images, {:as => :imagable}
  validates :title, presence: true, uniqueness: { scope: :collection_id, :if => :for_collection? }
  validates :description, presence: true, :if => :for_collection?
  validates :url, presence: true, uniqueness: { scope: :collection_id }
  validates :tag_list, presence: true, :unless => :for_collection?

  before_save :set_tag_owner

  # 链接是否是为某个合集添加的
  def for_collection?
    !self.collection_id.blank?
  end

  # 设置打标签的用户
  def set_tag_owner
    # Set the owner of some tags based on the current tag_list
    set_owner_tag_list_on(User.find(self.user_id), :tags, self.tag_list)
    # Clear the list so we don't get duplicate taggings
    self.tag_list = nil # 如果不这样会出现重复标签
  end

  def self.parser(link)
    return link if link.url.blank?

    link.url = 'http://' + link.url unless link.url.start_with?('http')
    begin
      timeout(3) do # 3秒
        page = Nokogiri::HTML(open(link.url))

        link.title = page.css("title").text if link.title.blank?
        if link.description.blank?
          description = page.xpath("//meta[translate(
            @name,
            'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
            'abcdefghijklmnopqrstuvwxyz'
          ) = 'keywords']/@content")
          link.description = description.blank? ? "" : description.first.value # 大小写不相关
        end
      end
    rescue Timeout::Error
      link.title = link.url if link.title.blank?
      return link
    end

    link
  end
end
