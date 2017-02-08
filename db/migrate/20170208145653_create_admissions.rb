class CreateAdmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :admissions do |t|
      t.integer :user_id
      t.string :care_family_name
      t.string :date_admitted
      t.string :date_discharged
      t.integer :admission_status_id
      t.integer :admission_type_id
      t.text :description

      t.timestamps
    end
    add_index :admissions, :user_id
    EnabledModule.where(name: 'admissions').first_or_create
  end
end
