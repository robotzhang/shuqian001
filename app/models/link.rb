class Link < ActiveRecord::Base
  attr_accessible :title, :url, :collection_id
  belongs_to :collection
  validates :title, presence: true, uniqueness: { scope: :collection_id }
  validates :url, presence: true, uniqueness: { scope: :collection_id }

  def self.new_from_url(url)
    link = Link.new
    return link if url.blank?
    page = Nokogiri::HTML(open(url))
    link.url = url
    link.title = page.css("title").text
    description = page.xpath("//meta[translate(
      @name,
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'abcdefghijklmnopqrstuvwxyz'
    ) = 'keywords']/@content")
    link.description = description.blank? ? "" : description.first.value # 大小写不相关

    link
  end
end
