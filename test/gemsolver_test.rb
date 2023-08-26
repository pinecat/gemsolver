require "test_helper"

class GemSolverTest < ActiveSupport::TestCase
  class Gemfu
    include GemSolver

    attr_reader :name, :requirements, :info_file, :stories, :versions, :version, :info, :quick_file, :gem_file

    def initialize(gem)
      @name = gem.name
      @requirements = gem.requirements_list

      @info_file = fetch_info
      @stories = InfoParser.parse(@info_file)
      @versions = SemVerParser.new(@stories, @requirements, @name)
      @version = @versions.available.first
      @info = InfoParser.info(@version, @stories)

      @quick_file = fetch_quick
      @gem_file = fetch_gem
    end
  end

  gem = Gem::Dependency.new("net-tofu", Gem::Requirement.new(["~> 0.3"]))
  gf = Gemfu.new(gem)

  test "it has a version number" do
    assert GemSolver::VERSION
  end

  test "it has a default host" do
    assert_equal "https://rubygems.org", gf.host
  end

  test "it can retrieve an info file" do
    assert_equal "---\n0.3.0 |checksum:0bd86c1919b13d4d11f1ebcff61c5fbd34a24735ee302c526b5c736ef8728506,ruby:>= 2.6.0\n", gf.info_file
  end

  test "it can parse entries in an info file" do
    vers03 = gf.stories.first
    assert_equal "0.3.0", vers03.version.to_s
    assert_equal "0bd86c1919b13d4d11f1ebcff61c5fbd34a24735ee302c526b5c736ef8728506", vers03.checksum
    assert_equal ">= 2.6.0", vers03.ruby.requirements_list.first.to_s
  end

  test "it can parse pessemistic versioning" do
    gem = Gem::Dependency.new("colorize", Gem::Requirement.new(["~> 0"]))
    g = Gemfu.new(gem)
    assert_equal "1.0.0.pre.1", g.version.to_s

    gem = Gem::Dependency.new("colorize", Gem::Requirement.new(["~> 1.0.0"]))
    g = Gemfu.new(gem)
    assert_equal "1.0.5", g.version.to_s
  end

  test "it can retrieve a quick file" do
    assert gf.quick_file
  end

  test "it can retrieve a gem file" do
    assert gf.gem_file
  end

  test "it can handle multiple dependencies" do
    gem_nokogiri = Gem::Dependency.new("nokogiri", nil)
    Gemfu.new(gem_nokogiri)

    gem_pry = Gem::Dependency.new("pry", nil)
    Gemfu.new(gem_pry)

    gem_psych = Gem::Dependency.new("psych", nil)
    Gemfu.new(gem_psych)
  end
end
