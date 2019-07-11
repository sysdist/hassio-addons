class MqttRequestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "Hello async job"

    connector = args[0]
    puts connector
    
  end

  
end
