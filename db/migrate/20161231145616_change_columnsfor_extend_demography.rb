class ChangeColumnsforExtendDemography < ActiveRecord::Migration[5.0]
  def change
    add_column :extend_demographies, :case_support_id, :integer
  end
end
