class SessionsController < ApplicationController
  def new
  end
	
	def create
		#logger.debug "debug!!!"
		#logger.debug params[:session][:email]
		user = User.find_by(email: params[:session][:email].downcase)
		#logger.debug user
		#logger.debug String(user.activated?)
		if user && user.authenticate(params[:session][:password])
			if user.activated?
				log_in user
				params[:session][:remember_me] == '1' ? remember(user) : forget(user)
				redirect_back_or root_url
				flash[:success] = 'You\'re right, man'				
			else
				#message = "Account not activated. "
				#message += "Check your email for the activation link."
				#flash[:warning] = message
				#flash[:info] = "If you can not find the email <a href='/account_activation/new'>Click Here</a> to resend".html_safe
				flash[:warning] = "Account not activated. Check your email for the activation link."
				flash[:info] = "If you can not find the email #{view_context.link_to "Click Here", { action: "resend_activation", controller: "account_activations", email: user.email }, method: :post} to get a new one".html_safe				
				redirect_to root_url
			end
		else
			# TODO change status
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end
	
	def destroy
		log_out if logged_in?
		redirect_to root_url
		flash[:info] = "Hope to see you soon!!!".html_safe
	end
end
