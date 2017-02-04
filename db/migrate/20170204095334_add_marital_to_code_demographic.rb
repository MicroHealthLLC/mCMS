class AddMaritalToCodeDemographic < ActiveRecord::Migration[5.0]
  def change
    add_column :core_demographics, :marital_status_id, :integer
  end
end
