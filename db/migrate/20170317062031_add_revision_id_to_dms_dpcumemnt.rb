class AddRevisionIdToDmsDpcumemnt < ActiveRecord::Migration[5.0]
  def change
    add_column :dms_documemnts, :revision_id, :integer
  end
end
