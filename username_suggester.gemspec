Gem::Specification.new do |s|
  s.name                      = "username_suggester"
  s.version                   = "0.3.0"
  s.summary                   = "Generates username suggestions for users"
  s.required_rubygems_version = ">= 1.3.6"
  s.authors                   = ["jerryluk", "fillman"]
  s.email                     = "jerry@presdo.com"
  s.files                     = Dir["{lib,spec}/**/*", "[A-Z]*", "init.rb"] - ["Gemfile.lock"]
  s.require_path              = "lib"
  s.homepage                  = "http://github.com/jerryluk/username_suggester"

  s.add_development_dependency 'with_model',   '~> 0.3'
  s.add_development_dependency 'rspec',        '~> 2.11.0'
  s.add_development_dependency 'activerecord', '~> 3.1'
  s.add_development_dependency 'rake',         '~> 0.9'
  s.add_development_dependency 'sqlite3',      '~> 1.3.6'
end

