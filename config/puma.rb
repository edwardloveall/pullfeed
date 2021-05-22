require "concurrent"

app_dir = File.expand_path("../..", __FILE__)
shared_dir = File.expand_path("#{app_dir}/shared", __FILE__)
pid_path = "#{shared_dir}/pids/puma.pid"
rails_env = ENV["RAILS_ENV"] || "production"
threads 1, 6
environment rails_env
pidfile pid_path
state_path "#{shared_dir}/pids/puma.state"

if rails_env != "development"
  bind "unix://#{shared_dir}/sockets/puma.sock"
  workers Concurrent.processor_count
  stdout_redirect(
    "#{app_dir}/log/puma.stdout.log",
    "#{app_dir}/log/puma.stderr.log",
    true
  )
else
  workers 1
end

activate_control_app
