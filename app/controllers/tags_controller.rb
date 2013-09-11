class TagsController < ApplicationController
  def index
    @tags = Collection.tag_counts_on(:tags).page(params[:page]).per(20)
  end

  def show
    @links = Link.tagged_with(params[:tag]).page(params[:page]).per(20)
    @tags = Link.tag_counts_on(:tags).limit(20)
  end
end
