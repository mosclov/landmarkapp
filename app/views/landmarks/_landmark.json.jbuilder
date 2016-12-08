json.extract! landmark, :id, :name, :description, :address, :website, :user_id, :created_at, :updated_at
json.url landmark_url(landmark, format: :json)