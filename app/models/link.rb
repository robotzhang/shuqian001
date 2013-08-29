#coding=utf-8
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'timeout'
require 'open-uri'

class Link < ActiveRecord::Base
  acts_as_commentable

  attr_accessible :title, :url, :description, :collection_id, :link_group_id
  belongs_to :collection
  belongs_to :user
  belongs_to :link_group
  has_many :votes, {:as => :votable, :dependent => :destroy}
  has_many :likes, {:as => :likable, :dependent => :destroy}
  validates :title, presence: true, uniqueness: { scope: :collection_id }
  validates :description, presence: true
  validates :url, presence: true, uniqueness: { scope: :collection_id }

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
