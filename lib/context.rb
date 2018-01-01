module Context
  MissingDependency = Class.new(StandardError)
  MissingContext = Class.new(StandardError)

  autoload :Injection, 'context/injection.rb'
  autoload :Version, 'context/version.rb'

  def self.[](*args)
    Context::Injection.new(*args)
  end
end
