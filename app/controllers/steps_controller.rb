class StepsController < ApplicationController
	before_action :logged_in_user,   only: [:edit, :update, :destroy, :new, :create, :index, :show]
  before_action :admin_user,       only: [:edit, :update, :destroy, :new, :create]	

	def create
		#TODO understand why it's with :step
		@line = Line.find(params[:step][:line_id])
		@installation = installation.find(params[:installation_id])
		@order = first_empty_order(@installation)
		@installation.addline(@line, @order)
		#redirect_to @installation
		respond_to do |format|
			format.html { redirect_to @installation }
			format.js
		end
	end
	
	def destroy
		@step = Step.find(params[:id])
		@installation = installation.find(@step[:installation_id])
		@order = @step[:order]
		@installation.removeline(@step, @order)
		@high = highest_order(@installation)
		if ((@order != @hign) && (@high != nil))
			@steps = all_step_of_installation(@installation)
			(@order..@high-1).each do |i|
				@steps[i].update(order: i)
			end
		end
		#redirect_to @installation		
		respond_to do |format|
			format.html { redirect_to @installation }
			format.js
		end
	end
	
	private
	
		def first_empty_order(installation)
			@steps = all_step_of_installation(installation)
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
	
		def highest_order(installation)
			@steps = all_step_of_installation(installation)
			if @steps.empty?
				return nil
			else
				return @steps.last[:order]
			end
		end
		
		def all_step_of_installation(installation)
			return Step.all.select {|step| step[:installation_id] == installation[:id] }.sort_by { |step| step[:order] }
		end
end
