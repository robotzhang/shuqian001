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
    @users = User.active
    render :template => "index"
  end

  def feedback
    render :template => "feedback"
  end

  def helps
    render :template => "helps"
  end

  # devise注销成功后返回的url
  def after_sign_out_path_for(resource_or_scope)
    params[:back] || root_path
  end

  # devise登陆成功后返回的url
  def after_sign_in_path_for(resource_or_scope)
    params[:back] || root_path
  end
end
