json.array!(@equipaments) do |equipament|
  json.extract! equipament, :id, :chave, :nome, :cidade, :estado
  json.url equipament_url(equipament, format: :json)
end
