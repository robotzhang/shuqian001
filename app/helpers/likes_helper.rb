module LikesHelper
  def link_do_like(object, text="收藏")
    link_to object.likes.count.to_s+text.html_safe,
            likes_path(object.class.to_s.underscore, object.id),
            remote: true,
            class: "muted",
            :method => "post"
  end

  def button_do_like(object, text="关注该标签")
    link_to text.html_safe,
            likes_path(object.class.to_s.underscore, object.id),
            remote: true,
            class: "btn btn-success btn-block",
            :method => "post"
  end
end
