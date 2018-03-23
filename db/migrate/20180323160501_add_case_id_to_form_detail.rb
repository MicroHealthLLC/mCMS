class AddCaseIdToFormDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :form_details, :case_id, :integer
  end
end
