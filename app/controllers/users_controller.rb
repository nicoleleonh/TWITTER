class UsersController < ApplicationController
    # before_action :user_params, only: [:show]
    def show
        @user = User.find(params[:id])
    end


    def follow
        @user = User.find(params[:id])
        if current_user.friendships.find_by(friend_id: @user.id).nil?
            current_user.friendships.create(friend_id: @user.id)
            redirect_to user_path(@user), notice: "Following #{@user.username}"
        else
            current_user.friendships.find_by(friend_id: @user.id).delete
            redirect_to user_path(@user), notice: "Unfollow #{@user.username}"
        end
    end
   
end