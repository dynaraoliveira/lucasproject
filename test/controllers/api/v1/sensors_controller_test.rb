require 'test_helper'

class Api::V1::SensorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_sensor = api_v1_sensors(:one)
  end

  test "should get index" do
    get api_v1_sensors_url
    assert_response :success
  end

  test "should get new" do
    get new_api_v1_sensor_url
    assert_response :success
  end

  test "should create api_v1_sensor" do
    assert_difference('Api::V1::Sensor.count') do
      post api_v1_sensors_url, params: { api_v1_sensor: {  } }
    end

    assert_redirected_to api_v1_sensor_url(Api::V1::Sensor.last)
  end

  test "should show api_v1_sensor" do
    get api_v1_sensor_url(@api_v1_sensor)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_v1_sensor_url(@api_v1_sensor)
    assert_response :success
  end

  test "should update api_v1_sensor" do
    patch api_v1_sensor_url(@api_v1_sensor), params: { api_v1_sensor: {  } }
    assert_redirected_to api_v1_sensor_url(@api_v1_sensor)
  end

  test "should destroy api_v1_sensor" do
    assert_difference('Api::V1::Sensor.count', -1) do
      delete api_v1_sensor_url(@api_v1_sensor)
    end

    assert_redirected_to api_v1_sensors_url
  end
end
