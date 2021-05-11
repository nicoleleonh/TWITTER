class ChangeColumnDefaultToTweet < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tweets, :retweets, 0
  end
end
