class CorrectImmunization < ActiveRecord::Migration[5.0]
  def change
    rename_column :immunizations, :immnunization_status_id, :immunization_status_id
  end
end
