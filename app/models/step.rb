class Step < ActiveRecord::Base
	belongs_to :instalation,  class_name: "Instalation"
  belongs_to :line,         class_name: "Line"
	validates :instalation_id, presence: true
	validates :line_id, presence: true
	validates :order,
						numericality: { only_integer: true, 
														less_than_or_equal_to: 100,
														greater_than_or_equal_to: 0							
													},
						presence: true
	
	#def maxorder
	#	Step.maximum("order")		
	#end
	
	def first_empty_order(instalation)
		@step = Step.all.select {|step| step[:instalation_id] == instalation_id }.sort_by { |step| step[:order] }
		@max = step.last[:order]
		(0..@max).each do |number|
			if number != @step[number][:order]
				return number
			end
		end
		return @max + 1
	end
end
