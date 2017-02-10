json.extract! award, :id, :user_id, :award_type_id, :award_enum_id, :award_date, :note, :created_at, :updated_at
json.url award_url(award, format: :json)