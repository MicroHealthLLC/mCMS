json.extract! form_result, :id, :user_id, :formular_id, :type, :name, :value, :long_value, :created_at, :updated_at
json.url form_result_url(form_result, format: :json)