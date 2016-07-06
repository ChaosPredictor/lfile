class Line < ActiveRecord::Base
	validates :content, 
						length: { maximum: 1024 },
						uniqueness: true,
						presence: true
	validates :index,
						numericality: { only_integer: true, 
														less_than_or_equal_to: 4096,
														greater_than_or_equal_to: -4096							
													},
						uniqueness: true, 
						presence: true
	has_many :instalations, 
					through: :steps
	has_many :steps
end