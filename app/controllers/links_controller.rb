class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new_from_url(params[:link][:url])
    @link.save
    respond_to do |format|
      format.js
    end
  end
end
