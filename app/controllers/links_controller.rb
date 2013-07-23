class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    respond_to do |format|
      format.js
    end
  end
end
