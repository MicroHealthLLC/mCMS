class ChangeGenderAndMeasuredByFromMeasuredby < ActiveRecord::Migration[5.0]
  def self.up
    Measurement.update_all({measured_by: nil, gender: nil})
    change_column :measurements, :measured_by, :integer
    change_column :measurements, :gender, :integer
    rename_column :measurements, :measured_by, :measured_by_id
    rename_column :measurements, :gender, :gender_id
  end

  def  self.down
    rename_column :measurements, :measured_by_id, :measured_by
    rename_column :measurements, :gender_id, :gender
    change_column :measurements, :measured_by, :string
    change_column :measurements, :gender, :string

  end

end
