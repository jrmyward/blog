json.array!(@list_subscribers) do |list_subscriber|
  json.extract! list_subscriber, :id
  json.url list_subscriber_url(list_subscriber, format: :json)
end
