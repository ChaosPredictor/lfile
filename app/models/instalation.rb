class Instalation < ActiveRecord::Base
	has_many :lines
	validates :name, 
						presence: true, 
						length: { maximum: 50 }, 
						uniqueness: { case_sensitive: false }
	validates :version, 
						presence: true, 
						length: { maximum: 20 }
	validates :source_link,
						length: { maximum: 128}
	#has_many :lines, 
	#				through: :steps,
	#				source: :line
	#has_many :steps
	has_many :active_steps, 	
						class_name: "Step",
						foreign_key: "instalation_id",
						dependent: :destroy
	has_many :hasline, #-> { order "steps[:order]" },#:order => 'active_steps.order',
					through: :active_steps,
					source: :line
	
	# Returns true if the current instalation has the line.
	def hasline?(line)
		lines.include?(line)
	end
	
	def line?(line)
		hasline.include?(line)
	end
	
	# Add line to instaaltion.
	def addline(line, order)
		#steps.create(instalation_id: self, line_id: line.id, order: order)
		active_steps.create(line_id: line.id, order: order)
	end
	
	# Reomve line from instalation.
	def removeline(step, order)
		#active_steps.find_by(line_id: line.id).destroy
		active_steps.find_by(id: step.id).destroy
		
		#active_relationships.find_by(followed_id: other_user.id).destroy
		#steps.find_by(instalation_id: self, line_id: line.id).destroy
	end
	
	def step?(line)
		true
	end
end
