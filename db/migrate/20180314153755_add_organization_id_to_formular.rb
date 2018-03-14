class AddOrganizationIdToFormular < ActiveRecord::Migration[5.0]
  def change
    add_column :formulars, :organization_id, :integer
  end
end
