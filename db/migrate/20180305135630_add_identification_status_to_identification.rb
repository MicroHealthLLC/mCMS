class AddIdentificationStatusToIdentification < ActiveRecord::Migration[5.0]
  def change
    add_column :identifications, :identification_status_id, :integer
  end
end
