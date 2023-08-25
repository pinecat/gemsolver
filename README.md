# Gem Solver
Gem Solver is a plugin for Rails that caches Ruby gems from any [rubygems.org](https://rubygems.org) compatible host.
It is built primarly to work with [GemCache](https://github.com/pinecat/gemcache).

## Installation
To use GemSolver in your rails project, first:
```
bundle add gemsolver
```

then:
```
rails g gemsolver:install
```

## Usage
```ruby
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

gem = Gem::Dependency.new("colorize", Gem::Requirement.new(["~> 1.0"]))
gemfu = Gemfu.new(gem)

File.binwrite("path/to/colorize.gem", gemfu.gem_file)
```

## Contributing
Bug reports and pull requests are welcome on Github at https://github.com/pinecat/gemsolver/issues and https://github.com/pinecat/gemsolver/pulls, respectively.

## License
The gem is available as open source under the terms of the [BSD 3-Clause License](https://opensource.org/license/bsd-3-clause/).
