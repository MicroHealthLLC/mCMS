class AddColumnToSetting < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :setting_type, :string
    add_column :settings, :value, :text
  end
end
