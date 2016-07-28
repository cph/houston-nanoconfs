$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "houston/nanoconfs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = "houston-nanoconfs"
  spec.version       = Houston::Nanoconfs::VERSION
  spec.authors       = "Chase Clettenberg"
  spec.email         = "chase.clettenberg@cph.org"

  spec.summary       = "Nanoconfs"
  spec.description   = "Nanoconfs"
  spec.homepage      = "https://github.com/cph/houston-nanoconfs"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.test_files = Dir["test/**/*"]

  spec.add_dependency "houston-core", ">= 0.7.0.beta4"

  spec.add_development_dependency "bundler", "~> 1.11.2"
  spec.add_development_dependency "rake", "~> 11.2"
end
