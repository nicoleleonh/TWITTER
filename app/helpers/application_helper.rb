module ApplicationHelper
    def like(tweet,user)
        tweet.likes.find{|like| like.user_id == user.id}
    end

    def render_with_hashtags(content)
        content_words = content.split(" ")
        content_with_links = content_words.map do |word| 
        if word[0] == "#"
            link_to word, tweets_url({q: {content_cont: word}})
        else
            word
        end
        end
    
        content_with_links.join(" ").html_safe
    end
end
