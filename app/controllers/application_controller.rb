class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
    @collections = Collection.all
    render :template => "index"
  end
end
