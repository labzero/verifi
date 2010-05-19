# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{verifi}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Wilson"]
  s.date = %q{2010-05-19}
  s.description = %q{A Ruby gem for Verifi.com's Hosted Payment Pages API.}
  s.email = %q{matt@labzero.com}
  s.extra_rdoc_files = ["README.txt", "LICENSE.txt"]
  s.files = ["HISTORY.txt", "README.txt", "lib/verifi.rb", "LICENSE.txt"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/labzero/verifi}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{A Ruby gem for Verifi.com's Hosted Payment Pages API.  Allows developers to create and read payment requests.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
  else
    s.add_dependency(%q<mime-types>, [">= 1.15"])
  end
end
