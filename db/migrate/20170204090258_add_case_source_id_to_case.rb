class AddCaseSourceIdToCase < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :case_source_id, :integer
  end
end
