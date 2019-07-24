# lib/tasks/cron_sync.rb
# ----------------------------------------------------------------- 
# sync all connectors from their MQTT status to DB via backend

Connector.all.pluck(:id).each do |conn_id|
  puts "Syncing connector number: #{conn_id}"
  ConnectorSyncJob.perform_now(conn_id)
end
