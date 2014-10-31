json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :num_quotes
  json.url user_url(user, format: :json)
end
