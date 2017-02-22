class CreateJobApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :job_applications do |t|
      t.integer :user_id
      t.string :employer
      t.string :position_applied
      t.string :projected_salary
      t.integer :application_type_id
      t.date :application_date
      t.integer :application_status_id
      t.integer :interview_type_id
      t.date :interview_date
      t.integer :interview_status_id
      t.integer :selection_status_id

      t.timestamps
    end
    add_index :job_applications, :user_id

    modules = ['injuries', 'job_applications', 'worker_compensations']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end

  end
end
