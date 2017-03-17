class AddRevisionIdToDmsDpcumemnt < ActiveRecord::Migration[5.0]
  def change
    add_column :dms_dpcumemnts, :revision_id, :integer
  end
end
