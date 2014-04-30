if ENV["RAILS_ENV"] == "production"
  worker_processes 2 # amount of unicorn workers to spin up
else
  worker_processes 1
end

timeout 30

# this is required for New Relic to log data
preload_app true
