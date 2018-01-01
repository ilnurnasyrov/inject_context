module Context::Injection
  def self.new(*args)
    injection = self.dup
    injection.define_helpers(*args)
    injection
  end

  def self.included(base)
    base.instance_variable_set('@_required_context_dependencies', @required_context_dependencies)

    def base.required_context_dependencies
      @_required_context_dependencies
    end
  end

  def self.define_helpers(*dependencies, **renamed_dependencies)
    @required_context_dependencies = dependencies + renamed_dependencies.keys

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

  def context=(context)
    missing_dependencies = self.class.required_context_dependencies - context.keys

    if missing_dependencies.any?
      raise Context::MissingDependency, "You didn't provide #{ missing_dependencies }"
    end

    @_context = context
  end

  def context
    @_context
  end
end
