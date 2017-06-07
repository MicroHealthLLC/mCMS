class AddRelatedReasonToReferral < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :related_reason_id, :integer
    add_column :referrals, :related_reason_type, :string
  end
end
