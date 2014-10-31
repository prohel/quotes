json.array!(@quotes) do |quote|
  json.extract! quote, :id, :author, :text
  json.url quote_url(quote, format: :json)
end
