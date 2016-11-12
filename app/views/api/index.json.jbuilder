json.array!(@users) do |user|
  json.extract! user, :id, :user_name
  json.url api_url(user, format: :json)
end