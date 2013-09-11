class LinksController < ApplicationController
  load_and_authorize_resource

  def index
    @links = Link.hottest.page(params[:page]).per(20)
  end

  def new
    @link = Link.new
    @link.tag_list = params[:tags] if !params[:tags].blank?
  end

  def create
    @link = Link.parser(Link.new(params[:link]))
    if params[:image_ids]
      @link.images = Image.find(params[:image_ids].split(",").map{|id| id.strip unless id.strip.blank?})
    end
    @link.user_id = current_user.id

    respond_to do |format|
      if @link.save
        format.html { redirect_to tag_path(@link.tags[0].name) }
      else
        format.html {render(:action => "new")}
      end
      format.js
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(params[:link])
  end

  def show
    @link = Link.find(params[:id])
    @commentable = @link

    Link.increment_counter(:views, @link.id) if !current_user || current_user.id != @link.user.id
  end

  # 添加分组
  def group
    @link_group = LinkGroup.new(params[:link_group])
    @link_group.save
  end
end
