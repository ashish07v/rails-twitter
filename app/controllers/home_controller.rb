class HomeController < ApplicationController
	before_action :set_no_cache
	before_action :require_login, except: %i[user_login]
	before_action :all_following, only: %i[index]
	def index
		unless session[:user_id]
	       redirect_to root_url
		end
		f_id = @following.pluck(:following_id)

		f_id<<@user.id

		# @usertweets = @user.tweets.order(updated_at: :desc) 
		@usertweets = Tweet.all.includes(:user).where(user_id: f_id).order(id: :desc) 
		tweet_ids = @usertweets.pluck(:id)
		@tweet_likes = Tweetlike.all.where(user_id: @user.id, tweet_id: tweet_ids).pluck(:tweet_id)
	end 

	def logout
		session[:user_id] = ''
		session.delete(:user_id)
		reset_session
		redirect_to root_url
	end 


	def set_no_cache
		response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
		response.headers["Pragma"] = "no-cache"
		response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
	end
end
