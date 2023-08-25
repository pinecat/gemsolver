module GemSolver
  #
  # Creates a list of appropriate gem and dependency versions
  # based on semantic versioning requirements. The latest
  # possible verions will always come first in the list.
  #
  class SemVerParser
    class Constraint
      def initialize(operator, version)
        @operator = operator.intern
        @version = Gem::Version.new(version)
      end

      def appropriate?(version)
        version.send(@operator, @version)
      end
    end

    # List of appropriate semantic versions, with the latest versions at the front of the list.
    attr_reader :available

    def initialize(stories, requirements, name)
      constraints = constrain(requirements)

      @available = []
      stories.each do |s|
        one_constraint_failed = false
        constraints.each do |c|
          unless c.appropriate?(s.version)
            one_constraint_failed = true
            break
          end
        end
        @available << s.version unless one_constraint_failed
      end

      raise NoAvailableVersionsError.new(name) if @available.blank?
    end

    private

    def constrain(requirements)
      constraints = []
      requirements.each do |r|
        operator, version = r.split(" ")

        case operator
        when "~>"
          # Pessimistic versioning (i.e. approximately greater than)
          constraints << Constraint.new(">=", version)

          if version.include?("-")
            version = version.split("-")[0]
          end

          if version.include?("+")
            version = version.split("+")[0]
          end

          mmp = version.split(".").map { |s| s.to_i }
          mmp.pop unless mmp.length == 1
          mmp[-1] += 1
          version = mmp.join(".")

          constraints << Constraint.new("<", version)
        when ">", ">=", "<", "<="
          constraints << Constraint.new(operator, version)
        when "="
          constraints << Constraint.new("==", version)
        else
          raise InvalidVersionConstraintError.new(operator)
        end

      end
      constraints
    end

  end
end
