class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :instalation_id
      t.integer :line_id
      t.integer :order

      t.timestamps null: false
    end
		add_index :steps, :instalation_id
		add_index :steps, :line_id
		add_index :steps, [:instalation_id, :order], unique: true
  end
end