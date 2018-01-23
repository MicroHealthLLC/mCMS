class AddCaseIdToWorkercompensation < ActiveRecord::Migration[5.0]
  def change
    add_column :worker_compensations, :case_id, :integer
    add_index :worker_compensations, :case_id
  end
end
