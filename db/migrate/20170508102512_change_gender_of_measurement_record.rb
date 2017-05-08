class ChangeGenderOfMeasurementRecord < ActiveRecord::Migration[5.0]
  def change
    MeasurementRecord.update_all({gender: nil})
    change_column :measurement_records, :gender, :integer
    rename_column :measurement_records, :gender, :gender_id
  end
end
