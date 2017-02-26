class AddColumnToMedication < ActiveRecord::Migration[5.0]
  def change
    add_column :medications, :rxcui, :string
    add_column :medications, :medication_name, :text
    add_column :medications, :medication_synonym, :text
    add_column :medications, :medication_tty, :string
  end
end
