# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mrb_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "mrb_manager"
  spec.version       = MrbManager::VERSION
  spec.authors       = ["YOSHIKAWA Ryota"]
  spec.email         = ["yoshikawa@rrreeeyyy.com"]
  spec.summary       = %q{mruby binary manager.}
  spec.description	 = %q{mruby binary manager.}
  spec.homepage      = "https://github.com/rrreeeyyy/mrb_manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "mgem"
  spec.add_runtime_dependency "ansi"
  spec.add_runtime_dependency "rubyzip"
  spec.add_runtime_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
