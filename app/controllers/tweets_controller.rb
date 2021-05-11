class TweetsController < ApplicationController
    before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet]

    def index
        @tweets = Tweet.all.order(id: :desc).page(params[:page])
        @tweet = Tweet.new
    end
    
    
    def show
        @tweets = Tweet.find(params[:id])
    end
    
  
    def new
        @tweet = Tweet.new
    end
    
      
    def edit
    end

    
   
    def create
        @user = current_user
        # Para crear un tuit al usuario
        @tweet = @user.tweets.new(tweet_params)
        respond_to do |format|
            if @tweet.save
                format.html { redirect_to tweets_url, notice: 'Tweet was successfully created.' }
            else
                format.html { render :new }
                
            end
        end
    end
    
    def retweet
        redirect_to root_path, alert: 'Cant do RT' and return if @tweet.user == current_user
        @retweeted = Tweet.new(content: @tweet.content, retweet_id: @tweet.id)
        @retweeted.user = current_user
        if @retweeted.save
            @tweet.update(retweets: @tweet.retweets += 1)
            redirect_to root_path, notice: 'RT Successful'
        else
            redirect_to root_path, alert: 'Cant do RT Successful'
        end
    end
    
    def update
        respond_to do |format|
            if @tweet.update(tweet_params)
                format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end
    
      
    def destroy
        @tweet.destroy
        respond_to do |format|
            format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
        end
    end
    
    private
        # Use callbacks to share common setup or constraints between actions.
    def set_tweet
        @tweet = Tweet.find(params[:id])
    end
    
       
    def tweet_params
        params.require(:tweet).permit(:content, :author_image, :likes, :retweets)
    end
end