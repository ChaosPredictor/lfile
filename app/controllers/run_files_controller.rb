class RunFilesController < ApplicationController
	#respond_to :html, :json
	
  def new
		@installations = Installation.all
  end
	
	def create
		logger.debug "Create start"
		number_of_installations = params[:@installations].count
		logger.debug number_of_installations
		@installations  =Installation.all
		logger.debug @installations
		logger.debug params[:@installations].keys
		@installation_key = params[:@installations].keys
		logger.debug @installation_key[0]
		@installation_array = []
		@line_array = []
		(0..number_of_installations-1).each do |counter|
			#if params[:@installations][String(counter)][:torun] == "1"
			if params[:@installations][@installation_key[counter]][:torun] == "1"
				@installation = @installations[counter]
				@installation_array.push(@installation)
				@steps = Step.all.select {|step| step[:installation_id] == @installation[:id] }.sort_by { |step| step[:order] }
				@steps.each do |step|
  				@line_array.push(Line.find(step.line_id)[:content])
				end
			end
		end
		@string = @line_array.join("\r\n")
		File.open('public/temp.txt', 'w') { |file| file.write(@string) }
  	download_file('public/temp.txt')
	end
	
	def download_file(file_path)
   send_file(file_path, :type => 'text/lfile', :disposition => "attachment")
	end
	
end
