class AddSnomedToLaboratoryExamination < ActiveRecord::Migration[5.0]
  def change
    add_column :laboratory_examinations, :snomed, :string
  end
end
