class AddCaseIdToJsignature < ActiveRecord::Migration[5.0]
  def change
    add_column :jsignatures, :case_id, :integer
    add_index :jsignatures, :case_id
  end
end
