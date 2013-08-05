#coding=utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to(root_url, :alert => exception.message) }
      format.js {render :js => "alert('请先登录');"}
    end
  end

  def index
    @collections = Collection.all
    render :template => "index"
  end

  def feedback
    render :template => "feedback"
  end
end
