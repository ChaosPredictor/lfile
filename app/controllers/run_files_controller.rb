class RunFilesController < ApplicationController
  def new
		@instalations = Instalation.all
  end
	
	def create
		@instalations = Instalation.find_by(id: params[:run_file][:send])
		redirect root_path
	end
end
