class AddIndexToInstallationsName < ActiveRecord::Migration
  def change
		add_index :installations, :name, unique: true
  end
end
