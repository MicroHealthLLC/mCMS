json.extract! enrollment, :id, :user_id, :name, :enrollment_type_id, :relationship_id, :date_start, :date_end, :note, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)