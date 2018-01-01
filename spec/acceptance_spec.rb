require 'spec_helper'

RSpec.describe "Context usage" do
  it 'adds .with that allows to provide context to instances' do
    expect {
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

      interactor = Interactor.new(:arg1, kwarg2: :val).within(context)
      interactor.call
    }.to output(<<~OUTPUT).to_stdout
      :fake_post_repo
      :fake_app_logger
      [:arg1, {:kwarg2=>:val}]
    OUTPUT
  end
end
