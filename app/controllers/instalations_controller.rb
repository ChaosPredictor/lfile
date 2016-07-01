class InstalationsController < ApplicationController
	before_action :logged_in_user,   only: [:edit, :update, :destroy, :index, :create, :new,  ]
  before_action :admin_user,       only: [:edit, :update, :destroy]	

	
	
	def index
		@instalations = Instalation.paginate(page: params[:page])
	end
	
	def new
		@instalation = Instalation.new
  end
	
	def create
		@instalation = Instalation.new(instalation_params)
		if @instalation.save
			redirect_to instalations_path
			flash[:success] = "New Instalation Saved!!!"
		else
			render 'new'
			flash[:error] = "There is a problem"
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
			flash[:success] = "You know what you're doing!"
			redirect_to instalations_path
			#flash[:error] = "You know what you're doing!"			
		else
			flash[:error] = "There is a problem"
			render 'edit'
		end
	end
	
	def destroy
		if Instalation.find(params[:id]).destroy
			flash[:success] = "Instalation deleted"
			redirect_to instalations_path
		else
			redirect_to root_path
		end
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
