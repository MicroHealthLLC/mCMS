json.extract! job_app, :id, :title, :occupation, :description, :app_state_id, :user_id, :created_at, :updated_at
json.url job_app_url(job_app, format: :json)