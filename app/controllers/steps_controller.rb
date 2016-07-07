class StepsController < ApplicationController
#	def create
#		#@instalation = Instalation.find(params[:instalation_id])
#		@instalation = Instalation.first
#		#@line = Line.find(params[:line_id])
#		@line = Line.first           #TODO change hardcore line
#		@instalation.addline(@line, 1)   #TODO change hardcore order
#		#redirect_to @user
#		redirect_to @instalation
#		#respond_to do |format|
#		#	format.html { redirect_to @instalation }
#		#	format.js
#		#end
#	end
	def destroy
		#@line = Step.find(params[:id]).line #followed
		@step = Step.find(params[:id])
		#@line_id = @step[:line_id]
		#@instalation_id = @step[:instalation_id]
		@line = Line.find(@step[:line_id])
		@instalation = Instalation.find(@step[:instalation_id])
		@order = @step[:order]
		@instalation.removeline(@line, @order)
		#redirect_to @instalation		
		respond_to do |format|
			format.html { redirect_to @instalation }
			format.js
		end
	end
	
	def create
		@line = Line.find(params[:step][:line_id])
		@instalation = Instalation.find(params[:instalation_id])
		@order = first_empty_order(@instalation)
		@instalation.addline(@line, @order)
		#redirect_to @instalation
		respond_to do |format|
			format.html { redirect_to @instalation }
			format.js
		end
	end
	
	
	private
	
		def first_empty_order(instalation)
			@step = Step.all.select {|step| step[:instalation_id] == instalation[:id] }.sort_by { |step| step[:order] }
			if @step.empty?
				return 0
			end
			@max = @step.last[:order]
			(0..@max).each do |number|
				if number != @step[number][:order]
					return number
				end
			end
			return @max + 1
		end
end
