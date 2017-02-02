class ChangeRelatioShipToEnrollmentStatus < ActiveRecord::Migration[5.0]
  def change
    rename_column :enrollments, :relationship_id, :enrollment_status_id
  end
end
