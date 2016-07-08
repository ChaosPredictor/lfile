class StepsController < ApplicationController
	before_action :logged_in_user,   only: [:edit, :update, :destroy, :new, :create, :index, :show]
  before_action :admin_user,       only: [:edit, :update, :destroy, :new, :create]	

	def destroy
		@step = Step.find(params[:id])
		@instalation = Instalation.find(@step[:instalation_id])
		@order = @step[:order]
		@instalation.removeline(@step, @order)
		@high = highest_order(@instalation)
		if ((@order != @hign) && (@high != nil))
			@steps = all_step_of_instalation(@instalation)
			(@order..@high-1).each do |i|
				@steps[i].update(order: i)
			end
		end
		#redirect_to @instalation		
		respond_to do |format|
			format.html { redirect_to @instalation }
			format.js
		end
	end
	
	def create
		#TODO understand why it's with :step
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
			@steps = all_step_of_instalation(instalation)
			if @steps.empty?
				return 0
			end
			@max = @steps.last[:order]
			(0..@max).each do |number|
				if number != @steps[number][:order]
					return number
				end
			end
			return @max + 1
		end
	
		def highest_order(instalation)
			@steps = all_step_of_instalation(instalation)
			if @steps.empty?
				return nil
			else
				return @steps.last[:order]
			end
		end
		
		def all_step_of_instalation(instalation)
			return Step.all.select {|step| step[:instalation_id] == instalation[:id] }.sort_by { |step| step[:order] }
		end
end
