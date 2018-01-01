module Context::Injection
  def self.new(*dependencies, **renamed_dependencies)
    injection = dup

    required_context_dependencies = dependencies + renamed_dependencies.keys

    injection.define_method(:required_context_dependencies) do
      required_context_dependencies
    end

    dependencies.each do |dependency|
      injection.define_method(dependency) do
        context[dependency]
      end
    end

    renamed_dependencies.each do |dependency, method_name|
      injection.define_method(method_name) do
        context[dependency]
      end
    end

    injection
  end

  def within(context)
    missing_dependencies = required_context_dependencies - context.keys

    if missing_dependencies.any?
      raise Context::MissingDependency, "You didn't provide #{ missing_dependencies }"
    end

    instance = dup
    instance.instance_variable_set('@_context', context)
    instance
  end

  def context
    @_context
  end
end
