class InstalationsController < ApplicationController
	before_action :logged_in_user,   only: [:index, :create, :new, :destroy, :edit, :update]
  before_action :admin_user,       only: [:destroy, :edit, :update]	

	
	
	def index
		@instalations = Instalation.paginate(page: params[:page])
	end
	
	def new
		@instalation = Instalation.new
  end
	
	def create
		@instalation = Instalation.new(instalation_params)
		if @instalation.save
			flash[:success] = "New Instalation Saved!!!"
			redirect_to root_url
		else
			render 'new'
		end
	end
	
	def show
		@instalation = Instalation.find(params[:id])
		#@microposts = @user.microposts.paginate(page: params[:page])
	end
	
	def edit
		@instalation = Instalation.find(params[:id])
	end
	
	def update
		@instalation = Instalation.find(params[:id])
		if @instalation.update_attributes(instalation_params)
			redirect_to instalations_path
			flash[:success] = "Nice Chose, Welcome back!"
		else
			render 'edit'
		end
	end
	
	def destroy
		Instalation.find(params[:id]).destroy
		flash[:success] = "Instalation deleted"
		redirect_to instalations_url
	end
	
	
	private
	
		def instalation_params
			params.require(:instalation).permit(:name, :version, :os)
		end
	
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
	
end
