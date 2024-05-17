# -*- encoding: utf-8 -*-
# stub: friendly_id-globalize 1.0.0.alpha4 ruby lib

Gem::Specification.new do |s|
  s.name = "friendly_id-globalize".freeze
  s.version = "1.0.0.alpha4".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Norman Clarke".freeze, "Philip Arndt".freeze]
  s.date = "2024-05-16"
  s.description = "Adds Globalize support to the FriendlyId gem.".freeze
  s.email = ["norman@njclarke.com".freeze, "p@arndt.io".freeze]
  s.files = [".gitignore".freeze, ".yardopts".freeze, "Gemfile".freeze, "MIT-LICENSE".freeze, "README.md".freeze, "Rakefile".freeze, "friendly_id-globalize.gemspec".freeze, "lib/friendly_id/globalize.rb".freeze, "lib/friendly_id/globalize/version.rb".freeze, "lib/friendly_id/history.rb".freeze, "lib/friendly_id/migration.rb".freeze, "lib/generators/friendly_id_globalize_generator.rb".freeze, "test/globalize_test.rb".freeze]
  s.homepage = "http://github.com/norman/friendly_id-globalize".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.5.9".freeze
  s.summary = "Globalize support for FriendlyId.".freeze

  s.installed_by_version = "3.5.9".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<friendly_id>.freeze, [">= 5.1.0".freeze, "< 6.0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<yard>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<globalize>.freeze, [">= 0".freeze])
end
