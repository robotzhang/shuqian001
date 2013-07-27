#coding=utf-8
class UsersController < ApplicationController
  load_and_authorize_resource :except => [:create]

  def index

  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to user_path(@user), :notice => '更新个人信息成功'
  end

  def show
    @user = User.find(params[:id])
  end
end
