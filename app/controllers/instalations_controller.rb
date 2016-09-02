class InstalationsController < ApplicationController
	#:index,
	before_action :logged_in_user,   only: [:edit, :update, :destroy, :create, :new, :show]
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
		#@user = current_user
		@instalation = Instalation.find(params[:id])
		#@lines = @instalation.hasline.paginate(page: params[:page])
		@steps = Step.all.select {|step| step[:instalation_id] == @instalation[:id] }.sort_by { |step| step[:order] }
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
	
	def tofile
		@new = para
		redirect_to root_path
	end
		
	private
	
		def instalation_params
			params.require(:instalation).permit(:name, :version, :os, :source_link, :torun)
		end
	
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
	
end
