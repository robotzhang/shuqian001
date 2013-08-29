class LinksController < ApplicationController
  load_and_authorize_resource
  def new
    @link = Link.new
  end

  def create
    @link = Link.parser(Link.new(params[:link]))
    @link.user_id = current_user.id
    @link.save
    respond_to do |format|
      format.js
    end
  end

  def show
    @link = Like.find(params[:id])

    Link.increment_counter(:views, @link.id) if !current_user || current_user.id != @link.user.id
  end

  # 添加分组
  def group
    @link_group = LinkGroup.new(params[:link_group])
    @link_group.save
  end
end
