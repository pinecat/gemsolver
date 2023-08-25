# frozen_string_literal: true

require "rails/generators/base"

module Gemsolver
  class InstallGenerator < Rails::Generators::Base
    desc "Create an initializer file for Gem Solver configuration options"
    def create_initializer_file
      create_file "config/initializers/gemsolver.rb", <<~RUBY
        # frozen_string_literal: true

        # GemCache configuration options.
        GemSolver.setup do |config|
          # The remote host to cache ruby gems from. This option may be overriden
          # directly or by setting the 'RAILS_GEMCACHE_HOST' environment
          # variable. The default option is https://rubygems.org. The remote host
          # must follow the distrubution pattern of rubygems.org, otherwise
          # GemCache will be unable to fetch gems from it.
          config.host = ENV["RAILS_GEMSOLVE_HOST"] || "https://rubygems.org"
        end
      RUBY
    end
  end
end
