ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_picture
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_picture]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column 'User_name', :username
    column 'Email', :email

    column 'Tweets quantity' do |user|
      user.tweets.count
    end
    
    column 'Likes quantity' do |user|
      user.likes.count
    end

    column :retweets do |user|
      user.tweets.where.not(retweet_id: id).count
    end

    column 'Friend' do |user|
      user.friends.count
    end
    actions
  end
  
end
