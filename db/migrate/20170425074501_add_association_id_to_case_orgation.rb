class AddAssociationIdToCaseOrgation < ActiveRecord::Migration[5.0]
  def change
    add_column :case_organizations, :association_id, :integer
  end
end
