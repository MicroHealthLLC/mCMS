class AddNewColumnsToAppointmentProcedure < ActiveRecord::Migration[5.0]
  def self.up
    add_column :appointment_procedures, :em_code_id, :integer
    add_column :appointment_procedures, :unit, :string
    add_column :appointment_procedures, :diagnosis_pointer, :string
    add_column :appointment_procedures, :epsdt_id, :integer
    add_column :appointment_procedures, :emergency_id, :integer
    add_column :appointment_procedures, :charges, :string
    add_column :appointment_procedures, :provider_id, :integer
    add_index :appointment_procedures, :provider_id
    Emergency.where(name: 'Y', active: true).first_or_create
    Emergency.where(name: 'N', active: true).first_or_create
    Epsdt.where(name: 'E', active: true).first_or_create
    Epsdt.where(name: 'F', active: true).first_or_create
    Epsdt.where(name: 'B', active: true).first_or_create
  end
 def self.down
    remove_index :appointment_procedures, :provider_id
    remove_column :appointment_procedures, :em_code_id, :integer
    remove_column :appointment_procedures, :unit, :string
    remove_column :appointment_procedures, :diagnosis_pointer, :string
    remove_column :appointment_procedures, :epsdt_id, :integer
    remove_column :appointment_procedures, :emergency_id, :integer
    remove_column :appointment_procedures, :charges, :string
    remove_column :appointment_procedures, :provider_id, :integer
  end
end
