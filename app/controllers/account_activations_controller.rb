class AccountActivationsController < ApplicationController
	
	def edit
		user = User.find_by(email: params[:email])
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

	def resend_activation
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
