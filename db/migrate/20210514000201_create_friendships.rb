class CreateFriendships < ActiveRecord::Migration[5.2]
  # https://stackoverflow.com/questions/50614670/activerecordstatementinvalid-sqlite3sqlexception-no-such-table
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.references :friend, foreign_key: false

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
