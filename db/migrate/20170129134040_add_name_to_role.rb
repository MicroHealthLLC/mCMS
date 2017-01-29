class AddNameToRole < ActiveRecord::Migration[5.0]
  def self.up
    add_column :roles, :name, :string
    Role.all.each do |role|
      role.name = role.role_type.to_s
      role.save
    end
  end

  def self.down
    remove_column :roles, :name, :string
  end
end
