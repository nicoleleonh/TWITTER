class Tweet < ApplicationRecord
    after_commit :create_hash_tags, on: :create
    
    # Asociaciones
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :tweet_hash_tags
    has_many :hash_tags, through: :tweet_hash_tags
    validates :content, presence: true

    scope :tweets_for_me, -> (friends_ids) {where(user_id: friends_ids)} 
    
    
    def timecreate
        if (Time.now - created_at) > 3600
            created_at.strftime('%H hours')
        else
            created_at.strftime('%M min')
        end
    end

    def create_hash_tags
        extract_name_hash_tags.each do |name|
         hash_tags.create(name: name)
        end
    end

    def extract_name_hash_tags 
        content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
    end

    # array con los usuarios que dieron like
    def users_likes
        likes.pluck(:user_id).map do |user_id|
            User.find(user_id)
        end
    end


    
end