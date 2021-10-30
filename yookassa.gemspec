# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yookassa/version"

Gem::Specification.new do |spec|
  spec.name          = "yookassa"
  spec.version       = Yookassa::VERSION
  spec.authors       = "Andrey Paderin"
  spec.email         = "andy.paderin@gmail.com"

  spec.summary       = "Yookassa API SDK for Ruby"
  spec.homepage      = "https://github.com/paderinandrey/yookassa"
  spec.license       = "MIT"

  spec.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files       = spec.files.grep(/^spec/)
  spec.extra_rdoc_files = Dir["README.md", "LICENSE", "CHANGELOG.md"]

  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6"

  spec.add_runtime_dependency "dry-initializer"
  spec.add_runtime_dependency "http", "~> 5.0.1"

  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rubocop", "~> 0.71"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "webmock", "~> 3.14"
end
