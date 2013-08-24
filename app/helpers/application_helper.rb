module ApplicationHelper
  def render_comment_id(commentable)
    'c_' + commentable.class.to_s.underscore + '_' + commentable.id.to_s
  end

  def myself_user?(user)
    return true if user_signed_in? && user.id == current_user.id
    false
  end
end
