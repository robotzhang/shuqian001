#coding=utf-8
class LinkGroupsController < ApplicationController
  load_and_authorize_resource

  def new
    @link_group = LinkGroup.new(collection_id: params[:collection_id])
  end

  def create
    @link_group = LinkGroup.new(params[:link_group])
    if @link_group.collection.blank? || @link_group.collection.user_id != current_user.id
      respond_to do |format|
        format.js {render :js => "alert('非法请求');"}
      end
    else
      @link_group.save
    end
  end

  def edit
    @link_group = LinkGroup.find(params[:id])
  end

  def update
    @link_group = LinkGroup.find(params[:id])
    @link_group.update_attributes(params[:link_group])
  end

  def destroy
    @link_group = LinkGroup.find(params[:id])
    @link_group.destroy
    redirect_to collection_path(@link_group.collection), :notice => "删除分组成功"
  end
end
