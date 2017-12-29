require "inject_context/version"

module InjectContext
  def self.[](*dependencies)
    new_module = InjectContext::Injection.dup
    new_module.define_helpers(*dependencies)
    new_module
  end
end

module InjectContext::Injection
  def self.included(base)
    base.extend(ClassMethods)
  end

  def self.define_helpers(*dependencies, **renamed_dependencies)
    dependencies.each do |dependency|
      define_method(dependency) do
        @_context[dependency]
      end
    end

    renamed_dependencies.each do |old_name, new_name|
      define_method(new_name) do
        @_context[old_name]
      end
    end
  end

  module ClassMethods
    def build(context = nil, *options)
      instance = new(*options)
      instance.instance_variable_set('@_context', context)
      instance
    end
  end
end

InjectContext::Injection.freeze
