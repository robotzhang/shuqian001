#require 'openssl'
#OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'timeout'

class Link < ActiveRecord::Base
  attr_accessible :title, :url, :collection_id
  belongs_to :collection
  validates :title, presence: true, uniqueness: { scope: :collection_id }
  validates :url, presence: true, uniqueness: { scope: :collection_id }

  def self.new_from_url(url)
    link = Link.new
    return link if url.blank?

    link.url = url
    begin
      timeout(3) do # 3秒
        page = Nokogiri::HTML(open(url))

        link.title = page.css("title").text
        description = page.xpath("//meta[translate(
          @name,
          'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          'abcdefghijklmnopqrstuvwxyz'
        ) = 'keywords']/@content")
        link.description = description.blank? ? "" : description.first.value # 大小写不相关
      end
    rescue Timeout::Error
      return link
    end

    link
  end
end
