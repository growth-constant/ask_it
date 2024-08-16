# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'questionnaire/version'

Gem::Specification.new do |s|
  s.name          = 'questionnaire'
  s.version       = Questionnaire::VERSION
  s.authors       = ['Victor Fernandez']
  s.email         = ['victor.j.fdez@gmail.com']
  s.homepage      = 'https://github.com/Victor Fernandez/questionnaire'
  s.licenses      = ['MIT']
  s.summary       = '[summary]'
  s.description   = '[description]'

  s.files         = Dir.glob('{bin/*,lib/**/*,[A-Z]*}')
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
end
