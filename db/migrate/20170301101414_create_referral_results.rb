class CreateReferralResults < ActiveRecord::Migration[5.0]
  def change
    create_table :referral_results do |t|
      t.integer :user_id
      t.integer :referral_id
      t.date :result_date
      t.text :result

      t.timestamps
    end
    add_index :referral_results, :user_id
    add_index :referral_results, :referral_id
  end
end
