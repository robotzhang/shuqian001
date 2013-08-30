class LinkGroupsController < ApplicationController
  def new
    @link_group = LinkGroup.new(collection_id: params[:collection_id])
  end

  def create
    @link_group = LinkGroup.new(params[:link_group])
    @link_group.save
  end

  def edit
    @link_group = LinkGroup.find(params[:id])
  end

  def update
    @link_group = LinkGroup.find(params[:id])
    @link_group.update_attributes(params[:link_group])
  end
end
