json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :chave, :sensor0, :sensor1, :sensor2, :sensor3, :sensor4, :sensor5, :datainclusao
  json.url sensor_url(sensor, format: :json)
end
