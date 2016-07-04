class Instalation < ActiveRecord::Base
	has_many :lines
	validates :name, 
						presence: true, 
						length: { maximum: 50 }, 
						uniqueness: { case_sensitive: false }
	validates :version, 
						presence: true, 
						length: { maximum: 20 }
	has_many :lines, through: :steps
	has_many :steps
	
	# Returns true if the current instalation has the line.
	def hasline?(line)
		lines.include?(line)
	end
	
	# Add line to instaaltion.
	def addline(line, order)
		steps.create(line_id: line.id, order: order)
	end
	
	# Reomve line from instalation.
	def removeline(line)
		steps.find_by(line_id: line.id).destroy
	end
	
	def allline
		
	end
	# Follows a user.
	#def addline(line, order)
	#	Step.create(instalation_id: self.id, line_id: line.id, order: order)
	#end
	
	def step?(line)
		true
	end
end
