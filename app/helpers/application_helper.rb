module ApplicationHelper
  def render_comment_id(commentable)
    'c_' + commentable.class.to_s.underscore + '_' + commentable.id.to_s
  end
end
