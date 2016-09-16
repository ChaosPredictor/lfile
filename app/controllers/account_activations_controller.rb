class AccountActivationsController < ApplicationController
	
	def edit
		user = User.find_by(email: params[:email])
		#logger.debug "Debug: AccountActivationsController - Edit"
		#logger.debug params[:email]
		#logger.debug params[:id]
		#logger.debug user
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			log_in user
			flash[:success] = "Account activated!"
			redirect_to user
		else
			flash[:danger] = "Invalid activation link"
			redirect_to root_url
		end
	end
	
	def update
		user = User.find_by(email: params[:id])
		#logger.debug "Debug: AccountActivationsController - Update"
		#logger.debug current_user
		#logger.debug params[:id]
		#logger.debug user
		if user && !user.activated? && current_user != nil && current_user.admin?
			user.activate
			flash[:success] = "#{user.name} Account activated!"
			redirect_to user
		else
			flash[:danger] = "It's not for you!"
			redirect_to root_path
		end
	end
		
	def resend_activation
		#logger.debug "Debug: AccountActivationsController - Resend Activation"
		#logger.debug "Debug: AccountActivationsController - Resend Activation"
  	user = User.find_by(email: params[:email])
  	if user
    	user.resend_activation_email
    	flash[:info] = "If the email that you enter right, Please check your email to activate your account."
    	redirect_to root_url
  	else
    	flash[:info] = "If the email that you enter right, Please check your email to activate your account."
			#flash[:danger] = "There was no account found for your e-mail address."
    	redirect_to root_url
  	end
	end
	
	
	
end
