module InjectContext
  MissingDependency = Class.new(StandardError)
  MissingContext = Class.new(StandardError)

  autoload :Injection, 'inject_context/injection.rb'
  autoload :InstanceBuilder, 'inject_context/instance_builder.rb'
  autoload :Version, 'inject_context/version.rb'

  def self.[](*args)
    InjectContext::Injection.build(*args)
  end
end
