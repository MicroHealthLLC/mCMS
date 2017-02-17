json.extract! allergy, :id, :user_id, :allergy_type_id, :medication, :allergy_date, :allergy_status_id, :description, :created_at, :updated_at
json.url allergy_url(allergy, format: :json)