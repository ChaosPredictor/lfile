class InstallationsController < ApplicationController
	#:index,
	before_action :logged_in_user,   only: [       :show, :new, :create, :edit, :update, :destroy]
  before_action :admin_user,       only: [                             :edit, :update, :destroy]	

	
	
	def index
		@installations = Installation.paginate(page: params[:page])
	end
	
	def new
		@installation = Installation.new
  end
	
	def create
		#@installation = Installation.new(installation_params)
		@installation = current_user.installations.build(installation_params)
		if @installation.save
			redirect_to installations_path
			flash[:success] = "New Installation Saved!!!"
		else
			render 'new'
			flash[:error] = "There is a problem"
		end
	end
	
	def show 
		@installation = Installation.find(params[:id])
		#if (current_user.admin? or @installation.user_id == current_user.id)
			@user = User.find(@installation.user_id)
			#@lines = @installation.hasline.paginate(page: params[:page])
			@steps = Step.all.select {|step| step[:installation_id] == @installation[:id] }.sort_by { |step| step[:order] }
			if @steps.empty?
				@lines = nil
			else
				@number_of_line = @steps.count
				@lines = Array.new(@number_of_line) {Line.new}
				(0..@number_of_line-1).each do |counter|
					@lines[counter] = Line.find(@steps[counter][:line_id])
				end
			end
			@title = "Lines"
		#else
		#	redirect_to root_url		
		#	flash[:danger] = "User can see only his installations!"	
		#end
	end
	
	def edit
		@installation = Installation.find(params[:id])
	end
	
	def update
		@installation = Installation.find(params[:id])
		if @installation.update_attributes(installation_params)

			flash[:success] = "You know what you're doing!"
			redirect_to installations_path
			#flash[:error] = "You know what you're doing!"		
			@installation.user_id = @installation.user_id_was
			@installation.save
		else
			flash[:error] = "There is a problem"
			render 'edit'
		end
	end
	
	def destroy
		if Installation.find(params[:id]).destroy
			flash[:success] = "Installation deleted"
			redirect_to installations_path
		else
			redirect_to root_path
		end
	end
	
	def tofile
		@new = para
		redirect_to root_path
	end
		
	private
	
		def installation_params
			params.require(:installation).permit(:name, :version, :os, :source_link, :torun, :user_id)
		end
	
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
	
end
