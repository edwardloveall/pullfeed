app_path = '/var/www/pullfeed'

# Set the working application directory
working_directory app_path

# Unicorn PID file location
pid "#{app_path}/pids/unicorn.pid"

# Path to logs
stderr_path "#{app_path}/log/unicorn.log"
stdout_path "#{app_path}/log/unicorn.log"

# Unicorn socket
listen "#{app_path}/sockets/unicorn.pullfeed.sock"

# Number of processes
worker_processes 2

# Time-out
timeout 30
