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
end
