class AddAssignedToIdToNeed < ActiveRecord::Migration[5.0]
  def change
    add_column :needs, :assigned_to_id, :integer
    add_column :goals, :assigned_to_id, :integer
    add_column :plans, :assigned_to_id, :integer

    add_index :needs, :assigned_to_id
    add_index :goals, :assigned_to_id
    add_index :plans, :assigned_to_id
  end
end
