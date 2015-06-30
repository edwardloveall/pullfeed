# Pull Feed

Subscribe to Pull Requests via RSS

### Production Installation

This is designed to be deployed on a CentOS 7 server. It will need the following environment variables to be set in the global environment:

```shell
export PULLFEED_PATH=/path/to/pullfeed
export RAILS_ENV=production
export RACK_ENV=production
```

### Bundle

When running `bundle`, run with the `--deployment` option to install gems in the `/ventor/bundle` directory. This will compartmentalize the gems.

### Starting and Stopping

Starting

```shell
# From the pullfeed directory
bundle exec unicorn_rails -c config/unicorn.rb -D
sudo service nginx restart
```

Stopping

```shell
# From the pullfeed directory
kill -QUIT `cat pids/unicorn.pid`
```
