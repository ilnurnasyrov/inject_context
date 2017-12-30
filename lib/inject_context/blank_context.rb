module InjectContext::BlankContext
  extend self

  def [](*)
    raise InjectContext::MissingContext, "Context wasn't provided"
  end

  def keys
    raise InjectContext::MissingContext, "Context wasn't provided"
  end
end
