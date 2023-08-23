require "gemcache/version"
require "gemcache/railtie"

module Gemcache
  # The host of the remote gem server
  mattr_accessor :host
  @@host = nil

  # Set configuration options.
  # This is typically done in the initializer ('rails g gemcache:install')
  def self.setup
    yield self
  end
end
