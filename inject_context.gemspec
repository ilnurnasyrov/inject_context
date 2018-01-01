
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "context/version"

Gem::Specification.new do |spec|
  spec.name          = "context"
  spec.version       = Context::VERSION
  spec.authors       = ["Ilnur Nasyrov"]
  spec.email         = ["ilnur.nasyrov.92@gmail.com"]

  spec.summary       = "Simple auto injector"
  spec.description   = "Simple auto injector that allows to pass dependencies in runtime"
  spec.homepage      = "https://github.com/ilnurnasyrov/context"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = ""

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
