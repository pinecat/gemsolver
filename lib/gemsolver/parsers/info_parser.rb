module GemSolver
  class InfoParser
    # The version of the gem from the info entry.
    attr_reader :version

    # A list of Gem::Dependencies from the info entry.
    attr_reader :dependencies

    # The SHA256 checksum of the gem from the info entry.
    attr_reader :checksum

    # The required Ruby version of the gem from the info entry.
    attr_reader :ruby

    # The required rubygems version of the gem from the info entry.
    attr_reader :rubygems

    def initialize(entry)
      # Split line into two parts:
      # (0) Semantic version and runtime dependencies
      # (1) Checksum and required ruby/rubygems versions
      split = entry.split("|")
      ver_and_deps = split[0].strip
      sha_and_ruby = split[1].strip

      # Parse each part of the entry in the info file
      parts = parse_version(ver_and_deps)
      parse_dependencies(parts)
      parts = parse_checksum(sha_and_ruby)
      parts = parse_ruby(parts)
      parse_rubygems(parts)
    end

    def self.info(version, stories)
      stories.each do |s|
        return s if s.version == version
      end
      nil
    end

    def self.parse(raw)
      stories = []
      raw.lines.drop(1).each do |l|
        stories << new(l)
      end
      stories.reverse
    end

    private

    def parse_version(raw)
      return if raw.blank?

      parts = raw.split(" ", 2)
      @version = Gem::Version.new(parts[0])
      parts.drop(1)
    end

    def parse_dependencies(parts)
      return if parts.blank?

      parts = parts.split(",")
      parts.flatten! if parts.length == 1
      @dependencies = []
      parts.each do |p|
        name, requirements = p.split(":")
        @dependencies << Gem::Dependency.new(name, requirements)
      end
    end

    def parse_checksum(raw)
      return if raw.blank?

      parts = raw.split(",")
      @checksum = parts[0].split(":")[1]
      parts.drop(1)
    end

    def parse_ruby(parts)
      return if parts.blank?

      @ruby = Gem::Dependency.new("ruby", parts[0].split(":")[1].split("&"))
      parts.drop(1)
    end

    def parse_rubygems(parts)
      return if parts.blank?

      @rubygems = Gem::Dependency.new("rubygems", parts[0].split(":")[1].split("&"))
    end
  end
end
