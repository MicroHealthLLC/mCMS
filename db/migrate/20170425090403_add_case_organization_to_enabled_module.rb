class AddCaseOrganizationToEnabledModule < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.create(name: 'case_organizations')
  end
end
