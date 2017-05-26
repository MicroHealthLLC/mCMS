class CreateLmsEnrollments < ActiveRecord::Migration
  def change
    create_table :lms_enrollments do |t|
      t.integer :course_id
      t.integer :student_id

      t.timestamps null: false
    end
    add_index :lms_enrollments, :course_id
    add_index :lms_enrollments, :student_id
  end
end
