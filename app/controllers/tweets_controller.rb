class TweetsController < ApplicationController
    before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet]

    def index
        # Scope para mostrar solo los tuits de mis amigos
        @q = Tweet.ransack(params[:q])

        if signed_in? 
            current_user_friends_ids = current_user.friends.pluck(:id)
            current_user_friends_ids.push(current_user.id)
            @tweets = Tweet.tweets_for_me(current_user_friends_ids).order(id: :desc).page(params[:page])
        else
            @tweets = @q.result(distinct: true).order(id: :desc).page(params[:page])
        end
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