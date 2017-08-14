class AddUserIdToCaseOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :case_organizations, :user_id, :integer
    add_index :case_organizations, :user_id

    CaseOrganization.includes(:case).references(:case).each do |case_organization|
      case_organization.update(user_id: case_organization.case.user_id)
    end
  end
end
