# Context

Simple runtime dependencies injector

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'context', git: 'https://github.com/ilnurnasyrov/context'
```

And then execute:

    $ bundle

## Usage
```ruby
  class Interactor
    include Context[:post_repo, app_logger: :logger]

    def initialize(*options)
      @options = options
    end

    def call
      puts post_repo.inspect
      puts logger.inspect
      puts @options.inspect
    end
  end

  context = { post_repo: :fake_post_repo, app_logger: :fake_app_logger }

  interactor = Interactor.with(context).new(:arg1, kwarg2: :val)
  interactor.call

  # output
  :fake_post_repo
  :fake_app_logger
  [:arg1, {:kwarg2=>:val}]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ilnurnasyrov/context. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Context project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ilnurnasyrov/context/blob/master/CODE_OF_CONDUCT.md).
