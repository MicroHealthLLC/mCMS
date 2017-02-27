class CreateClientOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :client_organizations do |t|
      t.string :name
      t.integer :organization_type_id
      t.integer :organization_id
      t.text :note

      t.timestamps
    end

    modules = ['referrals', 'jsignatures']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end

  end
end
