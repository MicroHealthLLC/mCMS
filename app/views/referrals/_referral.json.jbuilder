json.extract! referral, :id, :user_id, :title, :referral_type_id, :referral_date, :referral_appointment, :referral_status_id, :referred_by_id, :referred_to_id, :referral_reason, :created_at, :updated_at
json.url referral_url(referral, format: :json)