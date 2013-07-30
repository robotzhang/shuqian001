class CollectionsController < ApplicationController
  load_and_authorize_resource

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(params[:collection])
    @collection.user_id = current_user.id
    @collection.save ? redirect_to(user_path(current_user)) : render(:new)
  end

  def edit

  end

  def update

  end

  def show
    @collection = Collection.find(params[:id])
    @comment = Comment.new
    @comment.commentable = @collection
  end
end
