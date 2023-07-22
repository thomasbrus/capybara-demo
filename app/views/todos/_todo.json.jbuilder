json.extract! todo, :id, :title, :description, :finished_at, :deadline, :created_at, :updated_at
json.url todo_url(todo, format: :json)
