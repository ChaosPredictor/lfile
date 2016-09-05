class AddTorunToInstallations < ActiveRecord::Migration
  def change
    add_column :installations, :torun, :boolean, default: false
  end
end
