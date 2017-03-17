class AddSnomedToRadiologicExamination < ActiveRecord::Migration[5.0]
  def change
    add_column :radiologic_examinations, :snomed, :string
  end
end
