json.extract! referral_result, :id, :user_id, :referral_id, :result_date, :result, :created_at, :updated_at
json.url referral_result_url(referral_result, format: :json)