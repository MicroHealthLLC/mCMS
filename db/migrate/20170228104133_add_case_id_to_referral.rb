class AddCaseIdToReferral < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :case_id, :integer
    add_index :referrals, :case_id
  end
end
