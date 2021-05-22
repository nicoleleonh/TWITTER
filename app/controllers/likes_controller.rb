class LikesController < ApplicationController
  before_action :set_tweet
  before_action :set_like, only: [:destroy]
  def create
    if existing_like?
       flash[:notice] = 'ya le diste'
    else
      @tweet.likes.create(user_id: current_user.id)
    end
    redirect_to root_path
  end

  def destroy
    if existing_like?
      @like.destroy
    end
    redirect_to root_path
  end

  private
        # Use callbacks to share common setup or constraints between actions.
    def set_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end

    def set_like
      @like = @tweet.likes.find(params[:id])
    end

    def existing_like?
      Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
    end
    
end


            