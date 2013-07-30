#coding=utf-8
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
    @collection = Collection.find(params[:id])
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(params[:collection])
      redirect_to(collection_path(@collection), notice: "成功更新合集："+@collection.title)
    else
      render(:edit)
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @comment = Comment.new
    @comment.commentable = @collection
  end
end
