class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :taggings
  has_many :likes, {:as => :likable, :dependent => :destroy}

  # scopes 主要用于排序
  scope :latest, -> { order("id DESC") }
  scope :hottest, -> { order("likes_count DESC, views DESC, id DESC") }
  scope :amount, -> { order("taggings_count DESC, views DESC, id DESC") }

  # 统计信息
  def self.counts(tags)
    sql = "SELECT COUNT(id), taggable_type, tag_id FROM taggings WHERE tag_id IN(#{ tags.map{|tag| tag.id}.join(",") }) GROUP BY tag_id, taggable_type"
    items = ActiveRecord::Base.connection.execute(sql)

    hash = Hash.new
    items.each do |item|
      hash[item[2]] = [] if hash[item[2]].blank?
      hash[item[2]] << {counts: item[0], type: item[1]}
    end

    tags.each do |tag|

    end
  end

  # 热门标签,前20个
  def self.recommend
    Tag.hottest.limit(20)
  end
end
