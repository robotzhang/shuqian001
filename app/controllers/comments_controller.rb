class CommentsController < ApplicationController
  load_and_authorize_resource
  before_filter :load_commentable
  def create
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable }
        format.js
      else
        format.html { render :action => 'new' }
        format.js
      end
    end
  end

  protected
  def load_commentable
    @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  end
end
