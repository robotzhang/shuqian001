class TagsController < ApplicationController
  def index
    scope =  case params[:sort]
               when "latest" then Tag.latest
               when "hottest" then Tag.hottest
               when "amount" then Tag.amount
               else  Tag.hottest
             end
    @tags = scope.page(params[:page]).per(20)
  end

  def show
    @tag = Tag.find_by_name(params[:id])

    Tag.increment_counter(:views, @tag.id)
  end
end
