class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper
	
	private
		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
	
		def not_logged_in_user
			unless !logged_in?
				store_location
				flash[:danger] = "Log out first!"
				redirect_to root_url
			end
		end
	
		def case1
			unless (logged_in_user)
				store_location				
				flash[:danger] = "case1"
				redirect_to root_url
			end
		end
	
		def case2	
			logger.debug "case2z"
			logger.debug String(logged_in?)
			logger.debug String(Boolean(current_user))
			#logger.debug String(admin_user)
			unless logged_in? and (current_user or admin_user)
				store_location
				logger.debug "case2a"
				if not(logged_in?)
					logger.debug "case2b"
					flash[:danger] = "Please log in."
					redirect_to login_url
				else
					logger.debug "case2c"
					flash[:danger] = "case2"
					redirect_to root_url
				end
			end
		end
	
		def case3
			unless logged_in? and (!current_user and admin_user)
				store_location	
				if not logged_in?
					flash[:danger] = "Please log in."
					redirect_to login_url
				else
					flash[:danger] = "case3"
					redirect_to root_url
				end
			end
		end
	
		def case4	
			unless (current_user and admin_user)
				flash[:danger] = "case4"
				redirect_to root_url
			end
		end
	
	
	
		# Returns the current logged-in user (if any).
		def current_user
			if (user_id = session[:user_id])
				@current_user ||= User.find_by(id: user_id)
			elsif (user_id = cookies.signed[:user_id])
				user = User.find_by(id: user_id)
				if user && user.authenticated?(:remember, cookies[:remember_token])
				#TODO time expired
				#if (user && user.authenticated?(cookies[:remember_token])) && user.expired?(cookies[:expires])	
					log_in user
					@current_user = user
				end
			end
		end
	
		def admin_user
			if current_user
				redirect_to(root_url) unless current_user.admin?
			end
		end
	
end
