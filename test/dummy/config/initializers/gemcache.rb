# frozen_string_literal: true

# Gemcache configuration options.
Gemcache.setup do |config|
  # The remote host to cache ruby gems from. This option may be overriden
  # directly or by setting the 'RAILS_GEMCACHE_HOST' environment
  # variable. The default option is https://rubygems.org.
  config.host = ENV["RAILS_GEMCACHE_HOST"] || "https://rubygems.org"
end
