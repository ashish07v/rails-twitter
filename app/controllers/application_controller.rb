class ApplicationController < ActionController::Base

	# check user login status
	def require_login
		if session[:user_id]
	      @user = User.find_by(id: session[:user_id])
	      	if @user.blank?		      
		      redirect_to root_url
			end
	    else
	      redirect_to root_url
		end
	end	

	def all_following		
	    @following = @user.followers	      	
	end	

	def check_sign_in
		if session[:user_id]
			redirect_to twitter_url
		end
	end	
end
