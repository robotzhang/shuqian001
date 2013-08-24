#coding=utf-8
class UsersController < ApplicationController
  load_and_authorize_resource :except => [:create]
  before_filter :load_user

  def index

  end

  def update
    @user.update_attributes(params[:user])
    redirect_to user_path(@user), :notice => '更新个人信息成功'
  end

  def show
    @comment = Comment.new
    @comment.commentable = @user

    User.increment_counter(:views, @user.id) if !current_user || current_user.id != @user.id
  end

  #  关注用户
  def follow
    @follow = current_user.follow(@user) # 如果失败则返回nil
  end

  # 取消关注
  def unfollow
    @follow = current_user.stop_following(@user) # 删除成功则返回被删除的follow，否则返回nil
  end

  protected
  def load_user
    @user = User.find(params[:id])
  end
end
