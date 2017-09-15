json.extract! job, :id, :title, :employer, :application_stage_id, :user_id, :job_app_id, :position_type_id, :date, :application_status_id, :created_at, :updated_at
json.url job_url(job, format: :json)