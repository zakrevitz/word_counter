# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "word_counter/version"

Gem::Specification.new do |s|
  s.name = "word_counter"
  s.version = WordCounter::VERSION.dup
  s.platform = Gem::Platform::RUBY
  s.summary = "Word Counter"
  s.description = "Gem for counting words in txt/doc/docx/rtf/pdf and other documents"
  s.authors = "Yevhenii Shyshkov"
  s.email = "zakrevitz@gmail.com"

  s.files = Dir["{lib}/**/*"] + ["Rakefile"]
  s.test_files = Dir["{spec}/**/*"]
  s.require_paths = ["lib"]
  s.add_runtime_dependency('yomu', '~> 0.2.5')
  s.add_runtime_dependency('sanitize', '~> 4.2')
  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('webmock', '~> 2.1')
end
