class InjectContext::InstanceBuilder
  attr_reader :klass, :context

  def initialize(klass, context)
    @klass = klass
    @context = context
  end

  def new(*args)
    instance = klass.new(*args)
    instance.instance_variable_set("@_context", context)
    instance
  end
end
