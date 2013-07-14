worker_processes 4 # amount of unicorn workers to spin up
timeout 30         # restarts workers that timeout
preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  Rails.logger.info('Disconnected from ActiveRecord')
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
  Rails.logger.info('Connected to ActiveRecord')

  Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
  end
end
