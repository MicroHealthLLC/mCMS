json.extract! health_care_facility, :id, :user_id, :name, :health_care_facility_type_id, :health_care_facility_status_id, :health_care_facility_contact, :date_started, :date_end, :description, :created_at, :updated_at
json.url health_care_facility_url(health_care_facility, format: :json)