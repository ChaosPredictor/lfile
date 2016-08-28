class RunFilesController < ApplicationController
  def new
		@instalations = Instalation.all
  end
	
	def create
		logger.debug "Create start"
		number_of_instalations = params[:@instalations].count
		logger.debug number_of_instalations
		@instalations  =Instalation.all
		logger.debug @instalations
		logger.debug params[:@instalations].keys
		@instalation_key = params[:@instalations].keys
		logger.debug @instalation_key[0]
		@instalation_array = []
		@line_array = []
		(0..number_of_instalations-1).each do |counter|
			#if params[:@instalations][String(counter)][:torun] == "1"
			if params[:@instalations][@instalation_key[counter]][:torun] == "1"
				@instalation = @instalations[counter]
				@instalation_array.push(@instalation)
				@steps = Step.all.select {|step| step[:instalation_id] == @instalation[:id] }.sort_by { |step| step[:order] }
				@steps.each do |step|
  				@line_array.push(Line.find(step.line_id)[:content])
				end
			end
		end
		@string = @line_array.join("\r\n")
		File.open('public/temp.txt', 'w') { |file| file.write(@string) }
		#@instalations = Instalation.find_by(id: params[:instalations][:torun])
		#redirect root_path
		download_file('public/temp.txt')
	end
	
	def download_file(file_path)
   send_file(file_path, :type => 'text/csv', :disposition => "attachment")
	end
end
