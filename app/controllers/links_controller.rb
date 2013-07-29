class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.parser(Link.new(params[:link]))
    @link.save
    respond_to do |format|
      format.js
    end
  end
end
