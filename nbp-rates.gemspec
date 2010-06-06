# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nbp-rates}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Boguslaw Tarnowski"]
  s.date = %q{2010-06-06}
  s.description = %q{A library that download currency rates for PLN (polish zloty).}
  s.email = %q{}
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.rdoc", "lib/nbp-rates.rb"]
  s.files = ["CHANGELOG", "LICENSE", "README.rdoc", "Rakefile", "init.rb", "lib/nbp-rates.rb", "Manifest", "nbp-rates.gemspec"]
  s.homepage = %q{http://www.nbp.pl}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Nbp-rates", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{nbp-rates}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A library that download currency rates for PLN (polish zloty).}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 1.1.4"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.2"])
    else
      s.add_dependency(%q<libxml-ruby>, [">= 1.1.4"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.2"])
    end
  else
    s.add_dependency(%q<libxml-ruby>, [">= 1.1.4"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.2"])
  end
end
