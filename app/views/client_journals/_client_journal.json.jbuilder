json.extract! client_journal, :id, :title, :journal_type_id, :date, :note, :created_at, :updated_at
json.url client_journal_url(client_journal, format: :json)