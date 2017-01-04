class AddNotShowInSearch < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :not_show_in_search, :boolean, :default => false
    add_column :case_supports, :not_show_in_search, :boolean, :default => false
  end
end
