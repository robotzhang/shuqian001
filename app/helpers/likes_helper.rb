module LikesHelper
  def link_do_like(object, text="收藏")
    link_to object.likes.size.to_s+text.html_safe,
            likes_path(object.class.to_s.underscore, object.id),
            remote: true,
            class: "muted",
            :method => "post"
  end
end
