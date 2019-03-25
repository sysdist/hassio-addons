require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: { amount: @transaction.amount, average_price_per_kWh: @transaction.average_price_per_kWh, completed_at: @transaction.completed_at, connector_id: @transaction.connector_id, creditor_id: @transaction.creditor_id, currency: @transaction.currency, date_posted: @transaction.date_posted, debtor_id: @transaction.debtor_id, kWhs_used: @transaction.kWhs_used, meter_kWhs_finish: @transaction.meter_kWhs_finish, meter_kWhs_start: @transaction.meter_kWhs_start, status: @transaction.status } }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { amount: @transaction.amount, average_price_per_kWh: @transaction.average_price_per_kWh, completed_at: @transaction.completed_at, connector_id: @transaction.connector_id, creditor_id: @transaction.creditor_id, currency: @transaction.currency, date_posted: @transaction.date_posted, debtor_id: @transaction.debtor_id, kWhs_used: @transaction.kWhs_used, meter_kWhs_finish: @transaction.meter_kWhs_finish, meter_kWhs_start: @transaction.meter_kWhs_start, status: @transaction.status } }
    assert_redirected_to transaction_url(@transaction)
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url
  end
end
