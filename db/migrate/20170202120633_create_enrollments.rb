class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.string :name
      t.integer :enrollment_type_id
      t.integer :relationship_id
      t.date :date_start
      t.date :date_end
      t.text :note

      t.timestamps
    end

    EnabledModule.create(name: 'enrollments')
  end
end
