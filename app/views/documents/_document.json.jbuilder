json.extract! document, :id, :name, :is_private, :is_owner, :user_id, :created_at, :updated_at
json.url document_url(document, format: :json)
