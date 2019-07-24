# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# environmental variables 
env :PATH, ENV['PATH']
env :GEM_HOME, ENV['GEM_HOME']
env :BUNDLE_APP_CONFIG, ENV['BUNDLE_APP_CONFIG']
env :RUBY_MAJOR, ENV['RUBY_MAJOR']
env :RUBYGEMS_VERSION, ENV['RUBYGEMS_VERSION']
env :BUNDLE_BIN, ENV['BUNDLE_BIN']
env :BUNDLE_PATH, ENV['BUNDLE_PATH']
env :RUBY_VERSION, ENV['RUBY_VERSION']
env :BUNDLER_VERSION, ENV['BUNDLER_VERSION']
env :MQTT_URL, ENV['MQTT_URL']
# logs

#log_path = '/home/my_app/log'
app_path = '/home/stefan/www/hassio-addons/nabito/rootfs/app'
log_path = "#{app_path}/log"

set :output, {:standard => "#{log_path}/cron_log.log", :error => "#{log_path}/cron_error_log.log"}
# rails environment 
set :environment, 'development'
# change to the base directory of the application
# run the file with the rails runner task 
every 2.minutes do
   # command 'cd /home/my_app && bin/rails r lib/task/cron_sync.rb'
   command "cd #{app_path} && bin/rails r lib/tasks/cron_sync.rb"
end
