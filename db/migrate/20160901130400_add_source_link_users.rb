class AddSourceLinkUsers < ActiveRecord::Migration
  def change
		add_column :instalations, :source_link, :string
  end
end
