class AddNewStatusToEnumeration < ActiveRecord::Migration[5.0]
  def change
    add_column :enumerations, :is_flagged, :boolean, default: false
    add_column :enumerations, :is_closed, :boolean, default: false
  end
end
