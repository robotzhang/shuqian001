module LinksHelper
  def image?(url)
    [".gif", ".jpg", ".jpeg", ".png"].include?(File.extname(url).downcase)
  end

  def video?(url)
    [".swf"].include?(File.extname(url).downcase)
  end
end
