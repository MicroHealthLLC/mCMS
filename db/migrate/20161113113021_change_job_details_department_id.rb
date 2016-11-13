class ChangeJobDetailsDepartmentId < ActiveRecord::Migration[5.0]
  def self.up
    remove_belongs_to :job_details, :department , foreign_key: true
    add_column :job_details, :organization_id, :integer
  end

  def self.down
    add_belongs_to :job_details, :department , foreign_key: true
    remove_column :job_details, :organization_id, :integer
  end
end
