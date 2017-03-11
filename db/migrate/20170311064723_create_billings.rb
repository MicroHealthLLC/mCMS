class CreateBillings < ActiveRecord::Migration[5.0]
  def change
    create_table :billings do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.integer :bill_type_id
      t.integer :bill_status_id
      t.date :bill_date
      t.integer :bill_amount
      t.integer :accept_assignment_id
      t.string :resubmission_code
      t.string :original_reference_number
      t.string :prior_authorization_number
      t.integer :outside_lab_id
      t.float :outside_lab_charges
      t.integer :other_source_id
      t.float :total_charge
      t.float :amount_paid
      t.integer :created_by_id
      t.integer :updated_by_id
      t.text :note

      t.timestamps
    end
    add_index :billings, :user_id
    add_index :billings, :appointment_id

    vals = ['Yes', 'No']
    vals.each do |v|
      AcceptAssignment.where(name: v, active: true).first_or_create
      OutsideLab.where(name: v, active: true).first_or_create

    end

    modules = ['billings']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end


  end
end
