# Changelog
All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.1] - 2023-08-26
### Fixed
- Fixed a bug in the GemNotFoundError code, where it couldn't find the 'host' variable.

## [0.4.0] - 2023-08-26
### Fixed
- Sanitize version string inputs for Gem::Version.new.

## [0.3.2] - 2023-08-25
### Fixed
- Fix a bug in the InfoParser, where it couldn't handle multiple dependencies in an info file.

## [0.3.1] - 2023-08-25
### Fixed
- Update web info in spec file.

## [0.3.0] - 2023-08-25
### Fixed
- The install generator.

## [0.2.0] - 2023-08-25
### Fixed
- Changed library name.

## [0.1.1] - 2023-08-24
### Fixed
- Updated LICENSE.txt file in the gemspec files.
- Fixed the install generator.

## [0.1.0] - 2023-08-23
First release. The library is still fairly small, but there are a reasonable amount of tests, and
it is fulfilling all the functionality it needs to, so far.
### Added
- An install generator, which creates an initializer for GemCache.
- Methods to fetch:
  - An info file (<host>/info/<gem>)
  - A quick file (<host>/quick/Marshal.4.8/<gem>-<version>.gemspec.rz)
  - A gem file (<host>/gems/<gem>-<version>.gem)
- An info file parser.
- A semantic versioning parser (and dependency resolver).
- Custom errors:
  - GemNotFoundError: When any of the remote resources on <host> aren't available
  - InvalidVersionConstraintError: When an unrecognized version constraint is specified
  - NoAvailableVersionsError: When the constraints are too strict, or aren't inclusive enough
- Tests for the library.
- A proper README.md file.
