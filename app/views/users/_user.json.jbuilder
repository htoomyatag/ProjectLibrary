json.extract! user, :id, :username, :is_leave, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
