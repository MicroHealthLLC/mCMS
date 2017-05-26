class CreateLmsAssignments < ActiveRecord::Migration
  def change
    create_table :lms_assignments do |t|
      t.string :name
      t.text :body
      t.integer :course_id
      t.integer :teacher_id

      t.timestamps null: false
    end
  end
end
