class Instalation < ActiveRecord::Base
	validates :name, 
						presence: true, 
						length: { maximum: 50 }, 
						uniqueness: { case_sensitive: false }
	validates :version, 
						presence: true, 
						length: { maximum: 20 }
end
