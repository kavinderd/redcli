# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redcli/version'

Gem::Specification.new do |spec|
  spec.name          = "redcli"
  spec.version       = Redcli::VERSION
  spec.authors       = ["Kavinder Dhaliwal"]
  spec.email         = ["kavinderd@gmail.com"]
  spec.summary       = %q{Reddit Cli reader}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", '~> 0.10'
  spec.add_development_dependency "pry-debugger", '~> 0.2'
  spec.add_development_dependency "fakeweb", ["~> 1.3"]
  spec.add_development_dependency 'vcr', '~> 2.9.3' 

  spec.add_runtime_dependency "faraday", '~> 0.9'
  spec.add_runtime_dependency "main", '~> 6.1'
end
