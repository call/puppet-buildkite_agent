# @summary The main class for buildkite_agent
#
# Entrypoint for the module
#
# @example
#   include buildkite_agent
class buildkite_agent {
  include archive
  include buildkite_agent::install

  buildkite_agent::config { 'primary': }
}
