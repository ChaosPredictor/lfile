class Line < ActiveRecord::Base
	validates :content, 
						length: { maximum: 1024 },
						presence: true
	validates :index,
						numericality: { only_integer: true, 
														less_than_or_equal_to: 4096,
														greater_than_or_equal_to: -4096							
													},
						presence: true
end