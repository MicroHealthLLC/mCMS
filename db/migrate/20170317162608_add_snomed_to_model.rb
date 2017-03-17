class AddSnomedToModel < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :snomed, :string
    add_column :positions, :snomed, :string
    add_column :injuries, :snomed_occupation, :string
    add_column :injuries, :snomed_event, :string
    add_column :problem_lists, :snomed, :string
    add_column :medicals, :snomed, :string
    add_column :behavioral_risks, :snomed, :string
    add_column :family_histories, :snomed, :string
    add_column :allergies, :snomed, :string
    add_column :immunizations, :snomed, :string
    add_column :environment_risks, :snomed, :string
    add_column :documents, :snomed, :string
  end
end
