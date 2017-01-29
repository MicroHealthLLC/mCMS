class AddStatusToEducation < ActiveRecord::Migration[5.0]
  def change
    add_column :educations, :status_id, :integer
  end
end
