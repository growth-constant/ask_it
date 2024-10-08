# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'ask_it/version'

Gem::Specification.new do |s|
  s.name        = 'ask_it'
  s.version     = AskIt::VERSION
  s.summary     = %(Ask it is a user oriented tool that brings surveys into Rails applications. It is based on and inherits from Questionnaire, and Survey gems)
  s.description = %(A rails gem to enable surveys in your application as easy as possible)
  s.files       = Dir['{app,lib,config}/**/*'] + ['LICENSE.md', 'Rakefile', 'Gemfile', 'README.md']
  s.authors     = 'Victor'
  s.email       = 'victor@joinbuildit.com'
  s.homepage    = 'https://github.com/'
  s.licenses    = 'MITNFA'
  s.require_paths = %w[lib app]
  # add ruby version to the gemspec
  s.required_ruby_version = '>= 2.7.8'

  s.add_dependency('rails', '>= 6.1', '< 7.2')
  s.add_development_dependency 'appraisal', '~> 2.5.0'
  s.add_development_dependency('factory_bot')
  s.add_development_dependency('faker')
  s.add_development_dependency('faraday-retry')
  s.add_development_dependency('generator_spec')
  s.add_development_dependency('github_changelog_generator')
  s.add_development_dependency('mocha')
  s.add_development_dependency('pry')
  s.add_development_dependency('puma')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 3.13')
  s.add_development_dependency('rspec-rails', '>= 6.0')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('rubocop-factory_bot')
  s.add_development_dependency('rubocop-rails')
  s.add_development_dependency('rubocop-rake')
  s.add_development_dependency('rubocop-rspec')
  s.add_development_dependency('rubocop-rspec_rails')
  s.add_development_dependency('simplecov')
end
