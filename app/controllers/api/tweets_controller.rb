# class Api::TweetsController < ApplicationController
module Api
    class TweetsController < Api::ApplicationController

        def index
            @tweets = Tweet.all.limit(50)
            render json: tweets_to_json
        end

        def create
            @tweet = Tweet.new(user_id: current_user.id, content: params[:content])
            if @tweet.save
                render :json => @tweet
            else
                render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
            end
        end
        

        def date_filter
            @fecha1 = params[:fecha1]
            @fecha2 = params[:fecha2]

            @tweets = Tweet.all.where(created_at: @fecha1..@fecha2)
            render json: tweets_to_json
        end

        private

        def tweet_params
            params.require(:tweet).permit(:content, :user_id)
        end

        def tweets_to_json
            @tweets.map do |tweet|
                {
                    id: tweet.id,
                    content: tweet.content,
                    user_id: tweet.user_id,
                    like_count: tweet.likes.count,
                    retweets_count: tweet.retweets,
                    rewtitted_from: tweet.retweet_id,
                    created_at: tweet.created_at
                }
            end
        end
    end
end
