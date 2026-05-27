json.extract! todo, :id, :description, :high_priority, :created_at, :updated_at
json.url todo_url(todo, format: :json)
