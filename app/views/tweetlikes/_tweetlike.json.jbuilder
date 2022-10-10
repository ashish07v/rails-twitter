json.extract! tweetlike, :id, :created_at, :updated_at
json.url tweetlike_url(tweetlike, format: :json)
