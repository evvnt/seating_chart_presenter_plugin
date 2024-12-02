lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seating_chart_presenter_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = 'seating_chart_presenter_plugin'
  spec.version       = SeatingChartPresenterPlugin::VERSION
  spec.authors       = ["Tyler Lemburg", "Derek Graham", "Russell Edens"]
  spec.email         = ["derek@evvnt.com","rx@evvnt.com"]

  spec.summary       = %q{A COPRL presenter plugin for seats.io seating_chart}
  spec.homepage      = 'http://github.com/evvnt/seating_chart_presenters_plugin'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency "dry-configurable", ">= 0.13"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "bundler", "~> 2.0"
end
