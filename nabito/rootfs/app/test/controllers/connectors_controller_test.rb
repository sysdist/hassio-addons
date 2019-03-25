require 'test_helper'

class ConnectorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @connector = connectors(:one)
  end

  test "should get index" do
    get connectors_url
    assert_response :success
  end

  test "should get new" do
    get new_connector_url
    assert_response :success
  end

  test "should create connector" do
    assert_difference('Connector.count') do
      post connectors_url, params: { connector: { command_topic: @connector.command_topic, current_tnx: @connector.current_tnx, current_user: @connector.current_user, frequency: @connector.frequency, i_max: @connector.i_max, json_attributes_topic: @connector.json_attributes_topic, name: @connector.name, owner: @connector.owner, payload_off: @connector.payload_off, payload_on: @connector.payload_on, power: @connector.power, price_per_kWh: @connector.price_per_kWh, state: @connector.state, state_off: @connector.state_off, state_on: @connector.state_on, state_topic: @connector.state_topic, voltage: @connector.voltage } }
    end

    assert_redirected_to connector_url(Connector.last)
  end

  test "should show connector" do
    get connector_url(@connector)
    assert_response :success
  end

  test "should get edit" do
    get edit_connector_url(@connector)
    assert_response :success
  end

  test "should update connector" do
    patch connector_url(@connector), params: { connector: { command_topic: @connector.command_topic, current_tnx: @connector.current_tnx, current_user: @connector.current_user, frequency: @connector.frequency, i_max: @connector.i_max, json_attributes_topic: @connector.json_attributes_topic, name: @connector.name, owner: @connector.owner, payload_off: @connector.payload_off, payload_on: @connector.payload_on, power: @connector.power, price_per_kWh: @connector.price_per_kWh, state: @connector.state, state_off: @connector.state_off, state_on: @connector.state_on, state_topic: @connector.state_topic, voltage: @connector.voltage } }
    assert_redirected_to connector_url(@connector)
  end

  test "should destroy connector" do
    assert_difference('Connector.count', -1) do
      delete connector_url(@connector)
    end

    assert_redirected_to connectors_url
  end
end
