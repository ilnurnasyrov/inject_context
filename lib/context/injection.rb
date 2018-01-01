module Context::Injection
  def self.new(*args)
    injection = self.dup
    injection.define_helpers(*args)
    injection
  end

  def self.define_helpers(*dependencies, **renamed_dependencies)
    required_context_dependencies = dependencies + renamed_dependencies.keys

    define_method(:required_context_dependencies) do
      required_context_dependencies
    end

    dependencies.each do |name|
      define_method(name) do
        context[name]
      end
    end

    renamed_dependencies.each do |original_name, new_name|
      define_method(new_name) do
        context[original_name]
      end
    end
  end

  def within(context)
    missing_dependencies = required_context_dependencies - context.keys

    if missing_dependencies.any?
      raise Context::MissingDependency, "You didn't provide #{ missing_dependencies }"
    end

    instance = self.dup
    instance.instance_variable_set('@_context', context)
    instance
  end

  def context
    @_context
  end
end
