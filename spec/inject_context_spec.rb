RSpec.describe InjectContext do
  it { expect(InjectContext::VERSION).not_to be nil }

  it "adds .build method" do
    klass = Class.new { include InjectContext[] }

    expect(klass).to respond_to :build
    expect(klass.build).to be_instance_of klass
  end

  it "takes first argument as context and saves to @_context" do
    klass = Class.new { include InjectContext[] }

    context = Container.new
    instance = klass.build(context)

    expect(instance.instance_variable_get("@_context")).to eq context
  end

  it "passes arguments from build to new" do
    klass =
      Class.new do
        include InjectContext[]

        attr_reader :args

        def initialize(*args)
          @args = args
        end
      end

    expect(klass.build(Container.new, 1, 2).args).to eq [1, 2]
  end

  it "defines getters for context" do
    klass = Class.new { include InjectContext[:repo] }

    context = Container.new(repo: double(:repo))
    instance = klass.build(context)

    expect(instance).to respond_to :repo
    expect(instance.repo).to eq context[:repo]
  end

  it "allows use alternative names for getters" do
    klass = Class.new { include InjectContext[repo: :some_repo] }

    context = Container.new(repo: double(:repo))
    instance = klass.build(context)

    expect(instance).to respond_to :some_repo
    expect(instance.some_repo).to eq context[:repo]
  end

  it "checks container for missing dependencies" do
    klass = Class.new { include InjectContext[:repo, app_logger: :logger] }

    expect {
      klass.build(Container.new)
    }.to raise_error InjectContext::MissingDependency, "You didn't provide [:repo, :app_logger]"
  end
end

class Container
  def initialize(**dependencies)
    @dependencies = dependencies
  end

  def [](name)
    @dependencies[name]
  end

  def keys
    @dependencies.keys
  end
end
