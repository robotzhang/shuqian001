class UsersController < ApplicationController
  load_and_authorize_resource :except => [:create]

  def index

  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    render :show
  end

  def show
    @user = User.find(params[:id])
  end
end
