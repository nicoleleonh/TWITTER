class HashTag < ApplicationRecord
    has_many :tweet_hash_tags
    has_many :tweets, through: :post_hash_tags
end
