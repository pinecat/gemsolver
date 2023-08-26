require "gemsolver/version"
require "gemsolver/railtie"
require "gemsolver/errors"
require "gemsolver/parsers/info_parser"
require "gemsolver/parsers/sem_ver_parser"
require "net/http"
require "stringio"
require "rubygems/indexer"

module GemSolver
  #
  # The host of the remote gem server.
  # The default is https://rubygems.org.
  #
  mattr_accessor :host
  @@host = "https://rubygems.org"

  #
  # Set configuration options.
  # This is typically done in the initializer ('rails g gemcache:install')
  #
  def self.setup
    yield self
  end

  #
  # Fetch required gem info file.
  #
  # @return [String] The (YAML based?) info file.
  #
  def fetch_info
    info_uri = URI.parse("#{@@host}/info/#{@name}")
    response = Net::HTTP.get_response(info_uri)
    raise GemNotFoundError.new(@name) unless response.is_a? Net::HTTPSuccess
    response.body
  end

  #
  # Fetch required gem quick file.
  #
  # @return [String] The binary (compressed) quick file.
  #
  def fetch_quick
    quick_uri = URI.parse("#{@@host}/quick/Marshal.4.8/#{@name}-#{@version}.gemspec.rz")
    response = Net::HTTP.get_response(quick_uri)
    raise GemNotFoundError.new(@name) unless response.is_a? Net::HTTPSuccess
    response.body
  end

  #
  # Fetch required gem file.
  #
  # @return [String] The binary (compressed) gem file.
  #
  def fetch_gem
    gem_uri = URI.parse("#{@@host}/gems/#{@name}-#{@version}.gem")
    response = Net::HTTP.get_response(gem_uri)
    raise GemNotFoundError.new(@name) unless response.is_a? Net::HTTPSuccess
    response.body
  end
end
