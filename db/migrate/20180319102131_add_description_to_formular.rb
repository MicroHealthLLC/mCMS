class AddDescriptionToFormular < ActiveRecord::Migration[5.0]
  def change
    add_column :formulars, :description, :text
  end
end
