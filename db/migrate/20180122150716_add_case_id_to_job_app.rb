class AddCaseIdToJobApp < ActiveRecord::Migration[5.0]
  def change
    add_column :job_apps, :case_id, :integer
    add_index :job_apps, :case_id
  end
end
