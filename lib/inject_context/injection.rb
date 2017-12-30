module InjectContext::Injection
  def self.build(*args)
    injection = self.dup
    injection.define_helpers(*args)
    injection
  end

  # Kinda dirty
  def self.included(base)
    base.instance_variable_set('@_required_context_dependencies', @required_context_dependencies)

    def base.provide(context)
      missing_dependencies = @_required_context_dependencies - context.keys

      if missing_dependencies.any?
        raise InjectContext::MissingDependency, "You didn't provide #{ missing_dependencies }"
      end

      InjectContext::InstanceBuilder.new(self, context)
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
end

# InjectContext::Injection.define_helpers should not work on original module
InjectContext::Injection.freeze
