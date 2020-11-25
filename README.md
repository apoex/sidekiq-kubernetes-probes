# Sidekiq::Kubernetes::Probes

This gem injects code into Sidekiq that touches a file in the `tmp` directory
named `sidekiq_health`. This file can then be used by the Kubernetes liveness
probes to check that the worker is running properly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-kubernetes-probes'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sidekiq-kubernetes-probes

## Usage

### Download the script in your Dockerfile

The script is simple and checks that the heartbeat file has been updated in the
last `interval` seconds.

```dockerfile
RUN curl -f -o /usr/local/bin/sidekiq_health_check -L "https://raw.githubusercontent.com/apoex/sidekiq-kubernetes-probes/master/bin/sidekiq_health_check" && \
      chmod +x /usr/local/bin/sidekiq_health_check
```

```yaml
livenessProbe:
  timeoutSeconds: 1
  periodSeconds: 5
  exec:
    command:
      - sidekiq_health_check
      - tmp/sidekiq_health
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/micke/sidekiq-kubernetes-probes.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
