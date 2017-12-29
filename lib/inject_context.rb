require "inject_context/version"

module InjectContext
  def self.[](*args)
    injection = InjectContext::Injection.dup
    injection.define_helpers(*args)
    injection
  end
end

module InjectContext::Injection
  def self.included(base)
    # Kinda dirty
    def base.build(context = nil, *options)
      instance = new(*options)
      instance.instance_variable_set('@_context', context)
      instance
    end
  end

  def self.define_helpers(*dependencies, **renamed_dependencies)
    dependencies.each do |name|
      define_method(name) do
        @_context[name]
      end
    end

    renamed_dependencies.each do |original_name, new_name|
      define_method(new_name) do
        @_context[original_name]
      end
    end
  end
end

# InjectContext::Injection.define_helpers should not work on original module
InjectContext::Injection.freeze
