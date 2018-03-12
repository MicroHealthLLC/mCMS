class AddFormDetailToFormResult < ActiveRecord::Migration[5.0]
  def change
    add_column :form_results, :form_detail_id, :integer
    add_index :form_results, :form_detail_id
  end
end
