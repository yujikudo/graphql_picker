
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "graphql_picker/version"

Gem::Specification.new do |spec|
  spec.name          = "graphql_picker"
  spec.version       = GraphqlPicker::VERSION
  spec.authors       = ["yujikudo"]
  spec.email         = ["yuji.kudo@gmail.com"]

  spec.summary       = %q{Pickup Graphql query and mutaiton}
  spec.description   = %q{Pickup Graphql query and mutaito}
  spec.homepage      = "https://github.com/yujikudo/memo"
  spec.license       = "MIT"
  spec.required_ruby_version

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "graphql", "1.9.7"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
end
