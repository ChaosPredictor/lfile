class AddIndexToLinesIndex < ActiveRecord::Migration
  def change
		add_index :lines, :index, unique: true
  end
end
