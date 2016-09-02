class AddAddedByToInstalations < ActiveRecord::Migration
  def change
    add_reference :instalations, :user, index: true, foreign_key: true
  end
end
