class AddIndexToInstalationsName < ActiveRecord::Migration
  def change
		add_index :instalations, :name, unique: true
  end
end
