# frozen_string_literal: true

require "rails/generators/base"

module Gemcache
  class InstallGenerator < Rails::Generators::Base
    desc "Create an initializer file for Gemcache configuration options"
    def create_initializer_file
      create_file "config/initializers/gemcache.rb", <<~RUBY
        # frozen_string_literal: true

        # Gemcache configuration options.
        Gemcache.setup do |config|
          # The remote host to cache ruby gems from. This option may be overriden
          # directly or by setting the 'RAILS_GEMCACHE_HOST' environment
          # variable. The default option is https://rubygems.org.
          config.host = ENV["RAILS_GEMCACHE_HOST"] || "https://rubygems.org"
        end
      RUBY
    end
  end
end
