json.extract! user, :id, :full_name, :last_name, :age, :telephone, :roles_mask, :created_at, :updated_at
json.url user_url(user, format: :json)
