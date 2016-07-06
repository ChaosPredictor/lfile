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
		true
	end
	
	def create
		@line = Line.find(params[:line_id])
		@instalation = Instalation.find(params[:instalation_id])
		@instalation.addline(@line, 1)
		redirect_to @instalation
		#respond_to do |format|
		#	format.html { redirect_to @instalation }
		#	format.js
		#end
	end
end
