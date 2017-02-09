json.extract! legal, :id, :user_id, :title, :legal_history_id, :legal_history_status_id, :description, :date_start, :date_end, :created_at, :updated_at
json.url legal_url(legal, format: :json)