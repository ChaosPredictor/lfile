class Step < ActiveRecord::Base
	belongs_to :installation,  class_name: "Installation"
  belongs_to :line,         class_name: "Line"
	validates :installation_id, presence: true
	validates :line_id, presence: true
	validates :order,
						numericality: { only_integer: true, 
														less_than_or_equal_to: 100,
														greater_than_or_equal_to: 0							
													},
						presence: true
	
	#def move_down(installation)
	#	@steps = 		
	#end
end
