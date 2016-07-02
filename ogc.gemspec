# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'English'
require 'ogc/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '~> 2.1'

  spec.name    = 'ogc'
  spec.version = Ogc::VERSION
  spec.authors = ['Geoffrey Roguelon']
  spec.email   = ['geoffrey.roguelon@gmail.com']

  spec.summary     = 'Allow you to use WFS protocol defined by OGC.'
  spec.description = <<-STR
    This gems allow you to make calls in using Web Feature Service protocol
    defined by OGC (Open Geospatial Consortium) organization.
  STR
  spec.homepage    = 'https://github.com/GRoguelon/ogc'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    # rubocop:disable Metrics/LineLength
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
    # rubocop:enable Metrics/LineLength
  end

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '~> 1.6', '>= 1.6.6'
  spec.add_dependency 'activesupport', '>= 4.0', '< 5.1'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'guard', '~> 2.13'
  spec.add_development_dependency 'guard-minitest', '~> 2.4'
  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'rubocop', '~> 0.35'
end
