class CollectionsController < ApplicationController
  load_and_authorize_resource

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(params[:collection])
    @collection.user_id = current_user.id
    #current_user.tag(@collection, with: @collection.tag_list, on: :tags)
    @collection.save ? redirect_to(root_path) : render(:new)
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
