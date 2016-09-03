class OperatingSystem < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :version }
end
