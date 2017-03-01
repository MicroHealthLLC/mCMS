class CreateReferralRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :referral_relations do |t|
      t.integer :referral_parent_id
      t.integer :referral_child_id

      t.timestamps
    end
    add_index :referral_relations, :referral_parent_id
    add_index :referral_relations, :referral_child_id
  end
end
