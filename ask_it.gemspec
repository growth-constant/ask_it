# -*- encoding: utf-8 -*-
# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
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
  s.licenses    = 'LICENSE.md'
  s.require_paths = %w[lib app]

  s.add_dependency('rails', '>= 6.1')
  s.add_development_dependency('mocha')
  s.add_development_dependency('faker')
  s.add_development_dependency('rake')
  s.add_development_dependency('pry')
  s.add_development_dependency "appraisal", "~> 2.5.0"
  s.add_development_dependency('factory_bot')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('rspec', '~> 3.13')
  s.add_development_dependency('rspec-rails', '>= 6.0')
  s.add_development_dependency('simplecov')
end
