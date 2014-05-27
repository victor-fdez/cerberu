json.array!(@cheeses) do |cheese|
  json.extract! cheese, :id, :id, :about
  json.url cheese_url(cheese, format: :json)
end
