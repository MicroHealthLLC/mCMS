class RenameDepartmentToOrganization < ActiveRecord::Migration[5.0]
  def change
    rename_column :positions, :department_id, :organization_id
  end
end
