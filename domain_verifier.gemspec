# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domain_verifier/version'

Gem::Specification.new do |spec|
  spec.name          = "domain_verifier"
  spec.version       = DomainVerifier::VERSION
  spec.authors       = ["Harald Wartig"]
  spec.email         = ["hwartig@gmail.com"]
  spec.summary       = %q{Verifies a list of domains.}
  spec.description   = %q{Verifies if a list of domains is registered and pulls whois information for them.}
  spec.homepage      = "https://github.com/hwartig/domain_verifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
