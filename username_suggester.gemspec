Gem::Specification.new do |s|
  s.name = %q{username_suggester}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jerryluk"]
  s.date = %q{2010-06-30}
  s.description = %q{Generates username suggestions for users}
  s.email = %q{jerry@presdo.com}
  s.extra_rdoc_files = [
    "MIT-LICENSE",
    "README.rdoc"
  ]
  s.files = [
     ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "username_suggester.gemspec",
     "lib/username_suggester.rb",
     "lib/username_suggester/suggester.rb",
     "lib/username_suggester/suggestions_for.rb",
     "spec/suggestions_for_spec.rb",
     "spec/suggester_spec.rb",
     "spec/spec_helper.rb",
     "spec/db/database.yml",
     "spec/db/schema.rb"
  ]
  s.homepage = %q{http://github.com/jerryluk/username_suggester}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Generates username suggestions for users}
  s.test_files = [
    "spec/suggestions_for_spec.rb",
    "spec/suggester_spec.rb",
    "spec/spec_helper.rb",
    "spec/db/database.yml",
    "spec/db/schema.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

