# Change to match your CPU core count
workers 1

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path('../..', __FILE__)

# Default to production
rails_env = ENV['RAILS_ENV'] || 'production'
environment rails_env

# Set up socket location
bind "unix://#{app_dir}/tmp/sockets/puma.sock"

# Logging
stdout_redirect "#{app_dir}/log/puma.stdout.log",
                "#{app_dir}/log/puma.stderr.log",
                true

# Set master PID and state locations
pidfile "#{app_dir}/tmp/pids/puma.pid"
state_path "#{app_dir}/tmp/pids/puma.state"
activate_control_app

# Run in the background
daemonize true
