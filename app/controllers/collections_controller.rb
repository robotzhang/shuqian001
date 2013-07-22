class CollectionsController < ApplicationController
  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(params[:collection])
    @collection.save ? redirect_to(root_path) : render(:new)
  end

  def edit

  end

  def update

  end
end
