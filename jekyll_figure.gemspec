# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll_figure/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll_figure"
  spec.version       = JekyllFigure::VERSION
  spec.authors       = ["Lincoln Mullen"]
  spec.email         = ["lincoln@lincolnmullen.com"]
  spec.summary       = %q{Add a figure tag to output figures and captions in Jekyll}
  spec.homepage      = "https://github.com/lmullen/jekyll_figure"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
