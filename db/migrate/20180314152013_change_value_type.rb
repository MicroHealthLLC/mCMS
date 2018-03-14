class ChangeValueType < ActiveRecord::Migration[5.0]
  def self.up
    change_column :form_results, :value, :text
    remove_column :form_results, :long_value
    rename_column :form_results, :type, :form_type
  end

  def self.down
    change_column :form_results, :value, :string
    add_column :form_results, :long_value, :text
    rename_column :form_results, :form_type, :type
  end
end
