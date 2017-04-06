class AddPassWordSecurityToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      # other devise fields

      t.datetime :password_changed_at
      t.datetime :last_activity_at
      t.datetime :expired_at
      t.string :unique_session_id, :limit => 20
    end
    add_index :users, :password_changed_at
    add_index :users, :last_activity_at
    add_index :users, :expired_at

    create_table :old_passwords do |t|
      t.string :encrypted_password, :null => false
      t.string :password_archivable_type, :null => false
      t.string :password_salt
      t.integer :password_archivable_id, :null => false
      t.datetime :created_at
    end
    add_index :old_passwords, [:password_archivable_type, :password_archivable_id], :name => :index_password_archivable


  end
end
