# -*- encoding: utf-8 -*-
require File.expand_path('../lib/username_suggester/version', __FILE__)

Gem::Specification.new do |s|
  s.name                      = "username_suggester"
  s.version                   = UsernameSuggester::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.summary                   = "Generates username suggestions for users"
  s.required_rubygems_version = ">= 1.3.6"
  s.authors                   = ["jerryluk", "fillman"]
  s.email                     = ["jerry@presdo.com", "fila.luka@gmail.com"]
  s.files                     = `git ls-files`.split("\n")
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path              = ["lib"]
  s.homepage                  = "https://github.com/jerryluk/username_suggester"

  s.add_development_dependency 'with_model',   '~> 0.3'
  s.add_development_dependency 'rspec',        '~> 2.11.0'
  s.add_development_dependency 'activerecord', '~> 3.1'
  s.add_development_dependency 'rake',         '~> 0.9'
  s.add_development_dependency 'sqlite3',      '~> 1.3.6'
end

