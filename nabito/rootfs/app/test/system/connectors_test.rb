require "application_system_test_case"

class ConnectorsTest < ApplicationSystemTestCase
  setup do
    @connector = connectors(:one)
  end

  test "visiting the index" do
    visit connectors_url
    assert_selector "h1", text: "Connectors"
  end

  test "creating a Connector" do
    visit connectors_url
    click_on "New Connector"

    fill_in "Command topic", with: @connector.command_topic
    fill_in "Current tnx", with: @connector.current_tnx
    fill_in "Current user", with: @connector.current_user
    fill_in "Frequency", with: @connector.frequency
    fill_in "I max", with: @connector.i_max
    fill_in "Json attributes topic", with: @connector.json_attributes_topic
    fill_in "Name", with: @connector.name
    fill_in "Owner", with: @connector.owner
    fill_in "Payload off", with: @connector.payload_off
    fill_in "Payload on", with: @connector.payload_on
    fill_in "Power", with: @connector.power
    fill_in "Price per kwh", with: @connector.price_per_kWh
    fill_in "State", with: @connector.state
    fill_in "State off", with: @connector.state_off
    fill_in "State on", with: @connector.state_on
    fill_in "State topic", with: @connector.state_topic
    fill_in "Voltage", with: @connector.voltage
    click_on "Create Connector"

    assert_text "Connector was successfully created"
    click_on "Back"
  end

  test "updating a Connector" do
    visit connectors_url
    click_on "Edit", match: :first

    fill_in "Command topic", with: @connector.command_topic
    fill_in "Current tnx", with: @connector.current_tnx
    fill_in "Current user", with: @connector.current_user
    fill_in "Frequency", with: @connector.frequency
    fill_in "I max", with: @connector.i_max
    fill_in "Json attributes topic", with: @connector.json_attributes_topic
    fill_in "Name", with: @connector.name
    fill_in "Owner", with: @connector.owner
    fill_in "Payload off", with: @connector.payload_off
    fill_in "Payload on", with: @connector.payload_on
    fill_in "Power", with: @connector.power
    fill_in "Price per kwh", with: @connector.price_per_kWh
    fill_in "State", with: @connector.state
    fill_in "State off", with: @connector.state_off
    fill_in "State on", with: @connector.state_on
    fill_in "State topic", with: @connector.state_topic
    fill_in "Voltage", with: @connector.voltage
    click_on "Update Connector"

    assert_text "Connector was successfully updated"
    click_on "Back"
  end

  test "destroying a Connector" do
    visit connectors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Connector was successfully destroyed"
  end
end
