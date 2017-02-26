class CreateReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :referrals do |t|
      t.integer :user_id
      t.string :title
      t.integer :referral_type_id
      t.date :referral_date
      t.datetime :referral_appointment
      t.integer :referral_status_id
      t.integer :referred_by_id
      t.integer :referred_to_id
      t.text :referral_reason

      t.timestamps
    end
    add_index :referrals, :user_id
  end
end
