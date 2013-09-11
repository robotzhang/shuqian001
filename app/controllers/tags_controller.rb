class TagsController < ApplicationController
  def index
    @tags = Tag.order("views DESC, id DESC").page(params[:page]).per(20)
  end

  def show
    @tag = Tag.find_by_name(params[:id])

    Tag.increment_counter(:views, @tag.id)
  end
end
