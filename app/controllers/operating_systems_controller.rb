class OperatingSystemsController < ApplicationController
  before_action :logged_in_user,   only: [:edit, :update, :create]
  before_action :admin_user,   only: [:edit, :update, :create]
	
	def new
		@operating_system = OperatingSystem.new
  end
	
	def index
		@operating_systems = OperatingSystem.paginate(page: params[:page])
	end
	
	def create
		@operating_system = OperatingSystem.new(operating_system_params)
		if @operating_system.save
			redirect_to operating_systems_path
			flash[:success] = "New Operating System/Version added to list!"
		else
			render 'new'
		end
	end
	
	def edit
		@operating_system = OperatingSystem.find(params[:id])
	end
	
	def update
	end
	
	def destroy
		if OperatingSystem.find(params[:id]).destroy
			flash[:success] = "Operating System deleted from the list"
			redirect_to operating_systems_path
		else
			redirect_to root_path
		end
	end
	
	private
	
		def operating_system_params
			params.require(:operating_system).permit(:name, :version)
		end
end
