json.array!(@api_v1_sensors) do |api_v1_sensor|
  json.extract! api_v1_sensor, :id
  json.url api_v1_sensor_url(api_v1_sensor, format: :json)
end
