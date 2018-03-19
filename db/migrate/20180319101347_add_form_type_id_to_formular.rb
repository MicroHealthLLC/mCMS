class AddFormTypeIdToFormular < ActiveRecord::Migration[5.0]
  def change
    add_column :formulars, :form_type_id, :integer
  end
end
