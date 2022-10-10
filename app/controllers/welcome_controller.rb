class WelcomeController < ApplicationController
	before_action :set_no_cache
	def index
		# redirect_to home_path if logged_in?
	end


	def set_no_cache
		response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
		response.headers["Pragma"] = "no-cache"
		response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
	end
end
