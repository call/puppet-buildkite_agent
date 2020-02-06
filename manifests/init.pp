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

  create_resources(buildkite_agent::config, $configs)

  # if $configs {
  #   $configs.each |String $key, Hash[String, Variant[String, Integer, Boolean]]]

  #   buildkite_agent::config { $key:
  #   tags => 'queue=mini',
  # }
  # }
  # buildkite_agent::config { 'primary':
  #   tags => 'queue=mini',
  # }
}
