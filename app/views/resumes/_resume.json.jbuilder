json.extract! resume, :id, :user_id, :title, :date, :resume_type_id, :resume_status_id, :note, :created_at, :updated_at
json.url resume_url(resume, format: :json)