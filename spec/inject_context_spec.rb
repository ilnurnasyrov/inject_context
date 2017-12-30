RSpec.describe InjectContext do
  it { expect(InjectContext::VERSION).not_to be nil }

  it "adds .provide method" do
    klass = Class.new { include InjectContext[] }

    context = Container.new

    builder = klass.provide(context)

    expect(builder).to be_instance_of(InjectContext::InstanceBuilder)

    expect(builder.klass).to eq klass
    expect(builder.context).to eq context
  end

  it "defines accessor methods" do
    klass = Class.new { include InjectContext[:repo, logger: :app_logger] }

    expect(klass.instance_methods).to include :repo, :app_logger

    instance = klass.new

    instance.instance_variable_set('@_context', Container.new(repo: :repo, logger: :app_logger))

    expect(instance.repo).to eq :repo
    expect(instance.app_logger).to eq :app_logger
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
