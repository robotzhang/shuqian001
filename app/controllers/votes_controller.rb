class VotesController < ApplicationController
  before_filter :load_votable
  def create
    @vote = @votable.votes.build(params[:vote])
    @vote.user_id = current_user.id
    respond_to do |format|
      if @vote.save
        format.js
      else
        format.js
      end
    end
  end

  protected
  def load_votable
    @votable = params[:votable_type].camelize.constantize.find(params[:votable_id])
  end
end
