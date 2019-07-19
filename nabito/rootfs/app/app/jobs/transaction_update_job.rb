class TransactionUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    @tnx = args[0]
    task = args[1]
    case task
    when 'start'
      start_tnx
    when 'finish'
      end_tnx
    else
      puts 'Error in Transaction Update Job'
    end
  end

  def start_tnx
    @tnx.update(status: 'TNX_STARTED', meter_kWhs_start: @tnx.connector.current_kWh)
  end

  def end_tnx
    kWhs_finish = @tnx.connector.current_kWh
    total_kWhs = (kWhs_finish - @tnx.meter_kWhs_start).to_d
    a = total_kWhs * @tnx.average_price_per_kWh
    @tnx.update(meter_kWhs_finish: @tnx.connector.current_kWh,
                kWhs_used: total_kWhs, amount: a, completed_at: Time.now.utc,
                status: 'TNX_COMPLETE', date_posted: Date.today.to_s)
  end

end
