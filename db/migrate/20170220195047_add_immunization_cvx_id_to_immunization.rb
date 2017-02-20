class AddImmunizationCvxIdToImmunization < ActiveRecord::Migration[5.0]
  def change
    add_column :immunizations, :immunization_cvx_id, :integer
  end
end
