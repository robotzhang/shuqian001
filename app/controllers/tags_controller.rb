class TagsController < ApplicationController
  def index

  end

  def show
    @links = Link.tagged_with(params[:tag]).page(params[:page]).per(20)
    @tags = Link.tag_counts_on(:tags).limit(20)
  end
end
