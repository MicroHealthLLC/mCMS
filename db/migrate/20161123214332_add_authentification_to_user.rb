class AddAuthentificationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :database_authenticatable, :string, :null => true, :default => nil
    add_column :users, :ldap_authenticatable, :string, :null => false, :default => nil
  end
end
