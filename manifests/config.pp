# @summary Manages buildkite-agent configuration.
#
# Manages configuration for buildkite-agent
#
# @example
#   buildkite_agent::config { 'namevar': }
define buildkite_agent::config (
  String[1] $path   = '/usr/local/etc/buildkite-agent/buildkite-agent.cfg',
  String[1] $hooks  = '/usr/local/etc/buildkite-agent/hooks',
  String[1] $builds = '/usr/local/var/buildkite-agent/builds',
) {

  # Test creating ini file
  $defaults = { 'path' => '/tmp/foo.ini' }
  $example = { 'section1' => { 'setting1' => 'value1' } }
  create_ini_settings($example, $defaults)

}
