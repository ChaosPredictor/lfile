class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.string :name
      t.string :version
      t.string :os

      t.timestamps null: false
    end
  end
end
