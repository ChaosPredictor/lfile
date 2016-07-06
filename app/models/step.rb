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
end
