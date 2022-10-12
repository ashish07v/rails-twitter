class WelcomeController < ApplicationController
	before_action :set_no_cache, :check_session
	# before_action :check_session
	def index
		# redirect_to home_path if logged_in?
	end


	def set_no_cache
		response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
		response.headers["Pragma"] = "no-cache"
		response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
	end

	def check_session
		if session[:user_id]	     	      
		    redirect_to twitter_url			
	    end
	end
end
