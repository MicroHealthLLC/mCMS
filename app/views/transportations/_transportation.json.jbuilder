json.extract! transportation, :id, :user_id, :title, :transportation_mean_id, :transportation_type_id, :transportation_accessibility_id, :transportation_status_id, :description, :estimated_monthly_cost, :date_start, :date_end, :created_at, :updated_at
json.url transportation_url(transportation, format: :json)