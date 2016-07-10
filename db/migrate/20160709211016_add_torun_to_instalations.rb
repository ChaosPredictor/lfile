class AddTorunToInstalations < ActiveRecord::Migration
  def change
    add_column :instalations, :torun, :boolean, default: false
  end
end
