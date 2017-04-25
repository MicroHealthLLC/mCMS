class CreateCaseOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :case_organizations do |t|
      t.integer :case_id
      t.integer :organization_id

      t.timestamps
    end
    add_index :case_organizations, :case_id
    add_index :case_organizations, :organization_id
  end
end
