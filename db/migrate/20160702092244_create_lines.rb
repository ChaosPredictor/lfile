class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :content
      t.integer :index

      t.timestamps null: false
    end
  end
end
