class AddAddedByToInstallations < ActiveRecord::Migration
  def change
    add_reference :installations, :user, index: true, foreign_key: true
  end
end
