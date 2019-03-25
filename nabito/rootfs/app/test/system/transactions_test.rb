require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "creating a Transaction" do
    visit transactions_url
    click_on "New Transaction"

    fill_in "Amount", with: @transaction.amount
    fill_in "Average price per kwh", with: @transaction.average_price_per_kWh
    fill_in "Completed at", with: @transaction.completed_at
    fill_in "Connector", with: @transaction.connector_id
    fill_in "Creditor", with: @transaction.creditor_id
    fill_in "Currency", with: @transaction.currency
    fill_in "Date posted", with: @transaction.date_posted
    fill_in "Debtor", with: @transaction.debtor_id
    fill_in "Kwhs used", with: @transaction.kWhs_used
    fill_in "Meter kwhs finish", with: @transaction.meter_kWhs_finish
    fill_in "Meter kwhs start", with: @transaction.meter_kWhs_start
    fill_in "Status", with: @transaction.status
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "updating a Transaction" do
    visit transactions_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @transaction.amount
    fill_in "Average price per kwh", with: @transaction.average_price_per_kWh
    fill_in "Completed at", with: @transaction.completed_at
    fill_in "Connector", with: @transaction.connector_id
    fill_in "Creditor", with: @transaction.creditor_id
    fill_in "Currency", with: @transaction.currency
    fill_in "Date posted", with: @transaction.date_posted
    fill_in "Debtor", with: @transaction.debtor_id
    fill_in "Kwhs used", with: @transaction.kWhs_used
    fill_in "Meter kwhs finish", with: @transaction.meter_kWhs_finish
    fill_in "Meter kwhs start", with: @transaction.meter_kWhs_start
    fill_in "Status", with: @transaction.status
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Transaction" do
    visit transactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transaction was successfully destroyed"
  end
end
