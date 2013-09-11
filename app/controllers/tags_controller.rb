class TagsController < ApplicationController
  def index
    @tags = Tag.all
    @tags = Tag.counts(@tags)
  end

  def show
    @tag = Tag.find_by_name(params[:id])
  end
end
