json.extract! user_insurance, :id, :user_id, :insurance_id, :insurance_type_id, :insurance_identifier, :note, :created_at, :updated_at
json.url user_insurance_url(user_insurance, format: :json)