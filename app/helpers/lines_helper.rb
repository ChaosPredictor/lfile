module LinesHelper
	def current_instalation
		@instalation ||= Instalation.first
		#if (user_id = session[:user_id])
		#	@current_user ||= User.find_by(id: user_id)
		#elsif (user_id = cookies.signed[:user_id])
		#	user = User.find_by(id: user_id)
		#	if user && user.authenticated?(:remember, cookies[:remember_token])
			#TODO time expired
			#if (user && user.authenticated?(cookies[:remember_token])) && user.expired?(cookies[:expires])	
		#		log_in user
		#		@current_user = user
		#	end
		#end
	end
end
