class AddGenderToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :gender, :string
    add_column :core_demographics, :gender, :string
    add_column :measurement_records, :gender, :string
    add_column :measurements, :gender, :string
    Contact.all.each do |object|
      object.gender = object.gender_type.to_s
      object.save
    end
    CoreDemographic.all.each do |object|
      object.gender = object.gender_type.to_s
      object.save
    end
    MeasurementRecord.all.each do |object|
      object.gender = object.gender_type.to_s
      object.save
    end
    Measurement.all.each do |object|
      object.gender = object.gender_type.to_s
      object.save
    end
  end
end
