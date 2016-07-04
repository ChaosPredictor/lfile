class LinesController < ApplicationController
	before_action :logged_in_user,   only: [:edit, :update, :destroy, :new, :create, :show, :index]
  before_action :admin_user,       only: [:edit, :update, :destroy, :new, :create]
	
  def new
		@line = Line.new
  end
	
	def create
		@line = Line.new(line_params)
		#@line = current_instalation.lines.build(line_params)
		if @line.save
			redirect_to lines_path
			flash[:success] = "New Line Saved!!!"
		else
			#redirect_to lines_path
			#flash[:success] = "New Line Saved!!!"
			render 'new'
			#flash[:alert] = "There is a problem"
		end
	end
	
	def index
		@lines = Line.paginate(page: params[:page])		
	end
	
	def show
		@line = Line.find(params[:id])
	end
	
	def edit
		@line = Line.find(params[:id])
	end
	
	def update
		@line = Line.find(params[:id])
		if @line.update_attributes(line_params)
			flash[:success] = "You know what you're doing!"
			redirect_to lines_path
			#flash[ :error] = "You know what you're doing!"			
		else
			flash[:error] = "There is a problem"
			render 'edit'
		end
	end
	
	def destroy
		if Line.find(params[:id]).destroy
			flash[:success] = "Line deleted"
			redirect_to lines_path
		else
			redirect_to root_path
		end
	end
	
	private
		def line_params
			params.require(:line).permit(:content, :index)
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
end
