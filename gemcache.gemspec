require_relative "lib/gemcache/version"

Gem::Specification.new do |spec|
  spec.name        = "gemcache"
  spec.version     = GemCache::VERSION
  spec.authors     = ["Rory Dudley"]
  spec.email       = ["rory.dudley@gmail.com"]
  spec.homepage    = "https://github.com/pinecat/gemcache"
  spec.summary     = "Cache Ruby gems."
  spec.description = "Cache Ruby gems from a rubygems.org compatible host."
  spec.license     = "BSD 3-Clause"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pinecat/gemcache"
  spec.metadata["changelog_uri"] = "https://github.com/pinecat/gemcache/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "LICENSE.TXT", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.7.2"
end
