class ImagesController < ApplicationController
  #load_and_authorize_resource
  before_filter :load_imagable, :except => [:create]

  def create
    @image = Image.new
    if params[:image_file]
      @image.file = params[:image_file]
    else
      @image.remote_file_url = params[:remote_image_url]
    end

    @image.user_id = current_user.id
    @image.save

    render :text => {url: @image.file.url, id: @image.id}.to_json
  end

  protected
  def load_imagable
    @imagable = params[:imagable_type].camelize.constantize.find(params[:imagable_id])
  end
end
