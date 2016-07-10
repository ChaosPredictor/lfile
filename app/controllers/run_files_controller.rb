class RunFilesController < ApplicationController
  def new
		@instalations = Instalation.all
  end
	
	def create
		number_of_instalations = params[:@instalations].count
		@instalations  =Instalation.all
		@instalation_array = []
		(1..number_of_instalations).each do |counter|
			if params[:@instalations][String(counter)][:torun] == "1"
				@instalation_array.push(@instalations[counter-1])
			end
		end
		@instalations = Instalation.find_by(id: params[:instalations][:torun])
		redirect root_path
	end
end
