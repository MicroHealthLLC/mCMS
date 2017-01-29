class AddStatusToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :status_id, :integer
    add_column :other_skills, :status_id, :integer
    add_column :certifications, :status_id, :integer

    add_column :clearances, :status_id, :integer
    add_column :positions, :status_id, :integer
    add_column :affiliations, :status_id, :integer
    add_column :user_insurances, :status_id, :integer
  end
end
