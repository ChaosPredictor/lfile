class AddSourceLinkUsers < ActiveRecord::Migration
  def change
		add_column :installations, :source_link, :string
  end
end
