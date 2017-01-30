class AddLanguageTypeIdToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :language_type_id, :integer
  end
end
