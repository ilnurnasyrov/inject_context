module InjectContext
  MissingDependency = Class.new(StandardError)
  MissingContext = Class.new(StandardError)

  autoload :Injection, 'inject_context/injection.rb'
  autoload :Version, 'inject_context/version.rb'

  def self.[](*args)
    InjectContext::Injection.new(*args)
  end
end
