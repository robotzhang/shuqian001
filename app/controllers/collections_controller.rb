#coding=utf-8
class CollectionsController < ApplicationController
  load_and_authorize_resource

  def index
    @collections = Collection.includes([:links]).order("updated_at DESC").page(params[:page]).per(20)
  end

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
    @collection = Collection.includes([:links]).find(params[:id])
    @comment = Comment.new
    @comment.commentable = @collection

    Collection.increment_counter(:views, @collection.id) if !current_user || current_user.id != @collection.user.id
  end

  def tags
    @collections = Collection.tagged_with(params[:tag]).page(params[:page]).per(20)
    @tags = Collection.tag_counts_on(:tags).limit(20)
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    redirect_to user_path(current_user)
  end
end
