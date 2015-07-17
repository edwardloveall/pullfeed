# Pull Feed

Have you ever wanted to keep up with a GitHub repository, but you don't want notifications about everything that happens? This app generates an Atom feed of a given repository's incoming pull requests. Now, you can keep up with all of the open source projects you want on your terms.

Visit http://pullfeed.co to get the feed URL, or just use for format:

```
http://pullfeed.co/feeds/owner/repository
```

For example:

* [pullfeed.co/feeds/github/linguist](http://pullfeed.co/feeds/github/linguist)
* [pullfeed.co/feeds/thoughtbot/til](http://pullfeed.co/feeds/thoughtbot/til)
* [pullfeed.co/feeds/edwardloveall/pullfeed](http://pullfeed.co/feeds/edwardloveall/pullfeed)

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
bundle exec puma -d -b unix:///var/www/pullfeed/sockets/puma.sock --pidfile /var/www/pullfeed/pids/puma.pid
sudo service nginx restart
```

Stopping

```shell
# From the pullfeed directory
bundle exec pumactl -P pids/puma.pid stop
```

Restarting

```shell
bundle exec pumactl -P pids/puma.pid restart
sudo service nginx restart
```
