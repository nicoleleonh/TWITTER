class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy

    validates :content, presence: true



    def timecreate
        if (Time.now - created_at) > 3600
            created_at.strftime('%H hours')
        else
            created_at.strftime('%M min')
        end
    end

    # array con los usuarios que dieron like
    def users_likes
        likes.pluck(:user_id).map do |user_id|
            User.find(user_id)
        end
    end
end