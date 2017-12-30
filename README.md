# InjectContext

Simple runtime dependencies injector

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inject_context', git: 'https://github.com/ilnurnasyrov/inject_context'
```

And then execute:

    $ bundle

## Usage

### Basic usage
```ruby
  require 'inject_context'

  class UseCase
    include InjectContext[:post_repo, app_logger: :logger]

    def call
      puts post_repo.inspect
      puts logger.inspect
    end
  end

  context = { post_repo: "post_repo", app_logger: "app_logger" }

  UseCase.build(context).call
  #=> "post_repo"
  #=> "app_logger"
```

### Passing parameters to initializer

```ruby
  require 'inject_context'

  class UseCase
    include InjectContext[:post_repo, app_logger: :logger]

    def initialize(*params)
      @params = params
    end

    def call
      puts post_repo.inspect
      puts logger.inspect
      puts @params.inspect
    end
  end

  context = { post_repo: "post_repo", app_logger: "app_logger" }

  UseCase.build(context, :param1, :param2).call
  #=> "post_repo"
  #=> "app_logger"
  #=> [:param1, :param2]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ilnurnasyrov/inject_context. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the InjectContext project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ilnurnasyrov/inject_context/blob/master/CODE_OF_CONDUCT.md).
