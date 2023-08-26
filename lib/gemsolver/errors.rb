module GemSolver
  #
  # Raised when /info/<gem> cannot be found on the remote gem host.
  #
  class GemNotFoundError < StandardError
    def initialize(name)
      super("The '#{name}' gem could not be found on '#{GemSolver.host}'")
    end
  end

  #
  # Raised when an unrecognized version constraint is passed in a dependency.
  #
  class InvalidVersionConstraintError < StandardError
    def initialize(operator)
      super("The semantic versioning contraint '#{operator}' is not recognized")
    end
  end

  #
  # Raised when the version constraints are not inclusive enough to return a version.
  #
  class NoAvailableVersionsError < StandardError
    def initialize(name)
      super("There are no versions of '#{name}' that meet the specified version constraints")
    end
  end
end
