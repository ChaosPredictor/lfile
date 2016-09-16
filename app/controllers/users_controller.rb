class UsersController < ApplicationController
	before_action :not_logged_in_user,  only: [:new, :create]
	before_action :logged_in_user,      only: [              :index, :show, :edit, :update, :destroy, :following, :followers]
	before_action :correct_user,        only: [                      ]
	before_action :admin_user,          only: [              			    :destroy]
	

	
	
	def index
		#@users = User.all #without paginate
		@users = User.paginate(page: params[:page])
		#@users = User.where(activated: true).paginate(page: params[:page])
		#@users = User.all
	end	
	
	def show
		@user = User.find(params[:id])
		if (current_user?(@user) or current_user.admin?)
			@microposts = @user.microposts.paginate(page: params[:page])
		else
			redirect_to root_url		
			flash[:danger] = "Log in as a right user!"			
		end
	end

  def new
		@user = User.new
  end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			#UserMailer.account_activation(@user).deliver_now
			#log_in @user
			flash[:success] = "Please check your email to activate your account."
			redirect_to root_url
		else
			render 'new'
		end
	end
	
	def edit
		@user = User.find(params[:id])
		if (current_user?(@user) or current_user.admin?)
		else
			redirect_to root_url		
			flash[:danger] = "Log in as a right user!"			
		end
	end
	
	def update
		@user = User.find(params[:id])
		if (current_user?(@user) or current_user.admin?)
			if @user.update_attributes(user_params)
			#flash[:success] = "Profile updated"
				redirect_to @user
				if current_user?(@user)
					if current_user.admin?
						flash[:success] = "As usual, Nice Chose, Boss!"
					else
						flash[:success] = "Nice Chose, Welcome back!"	
					end
				else
					flash[:success] = "Nice Chose, Boss!"
				end
				#redirect_to @user
			else
				render 'edit'
			end
		else
			redirect_to root_url		
			flash[:danger] = "Log in as a right user!"	
		end
	end
	
	def destroy
		@user = User.find(params[:id])
		if current_user?(@user)
			flash[:danger] = "You can't do it for yourself, Boss!"
			redirect_to root_url
		else
			@user.destroy
			flash[:success] = "Yes it was a bad guy, Boss!"
			redirect_to users_url
		end
	end
	
	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(page: params[:page])
		render 'show_follow'
	end
	
	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end
	
	private
	
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
	
		# Before filters
	
		# Confirms a logged-in user.
		#def logged_in_user
		#	unless logged_in?
		#		store_location
		#		flash[:danger] = "Please log in."
		#		redirect_to login_url
		#	end
		#end
	
		# Confirms the correct user.
		def correct_user
			@user = User.find(params[:id])
			unless current_user?(@user)
				flash[:danger] = "Log in as a right user!"
				redirect_to root_url
			end
		end
	
		# Confirms an admin user.
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
