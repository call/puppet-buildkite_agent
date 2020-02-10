# @summary The main class for buildkite_agent
#
# Entrypoint for the module
#
# @example
#   include buildkite_agent
class buildkite_agent (
  String[1] $token,
  Optional[Hash[String, Hash[String, Variant[String, Integer, Boolean]]]] $configs,
  Optional[Hash[String, Hash[String, Variant[String, Integer, Boolean]]]] $services,
) {

  include archive
  include buildkite_agent::install

  if $configs {
    create_resources(buildkite_agent::config, $configs)
  }

  if $services {
    create_resources(buildkite_agent::service, $services)
  }

}
