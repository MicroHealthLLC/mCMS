class AddOccupationIdToPosition < ActiveRecord::Migration[5.0]
  def change
    add_column :positions, :occupation_id, :integer
  end
end
