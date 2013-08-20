class LikesController < ApplicationController
  load_and_authorize_resource
  before_filter :load_likable

  def create
    @like = build_like
    @like.save
  end

  protected
  def build_like
    like = Like.new
    like.likable_type = params[:likable_type]
    like.likable_id = params[:likable_id]
    like.user_id = current_user.id

    like
  end

  def load_likable
    @likable = params[:likable_type].camelize.constantize.find(params[:likable_id])
  end
end
