# @summary The main class for buildkite_agent
#
# Entrypoint for the module
#
# @example
#   include buildkite_agent
class buildkite_agent (
  Optional[Hash[String, Hash[String, Variant[String, Integer, Boolean]]]] $configs,
) {
  include archive
  include buildkite_agent::install

  if $configs {
    create_resources(buildkite_agent::config, $configs)
  }

}
