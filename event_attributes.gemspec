# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "event_attributes/version"

Gem::Specification.new do |spec|
  spec.name          = "event_attributes"
  spec.version       = EventAttributes::VERSION
  spec.authors       = ["Bob Lail", "Ben Govero"]
  spec.email         = ["bob.lail@cph.org", "ben.govero@cph.org"]
  spec.summary       = %q{Normalizes params posted from an event form}
  spec.description   = %q{Normalizes params posted from an event form}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails", ">= 3.2.8", "< 4.1.0"
  spec.add_development_dependency "turn"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "shoulda-context"
  spec.add_development_dependency "pry"

end
