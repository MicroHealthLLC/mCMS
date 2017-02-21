class RenameColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :surgicals, :hcpc_id, :integer
    add_column :appointment_captures, :icdcm_code_id, :integer
    add_column :appointment_procedures, :hcpc_id, :integer
  end
end
