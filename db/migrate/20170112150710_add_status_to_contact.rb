class AddStatusToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :status, :boolean, default: true
    add_column :case_supports, :status, :boolean, default: true
  end
end
