# @summary Manages launchd jobs for buildkite-agent.
#
# Creates and ensures state of LaunchAgents
#
# @example
#   buildkite_agent::service { 'namevar': }
define buildkite_agent::service (
  String[1] $user,
  String[1] $bk_name,
  Enum['stopped', 'running'] $ensure = 'running',
  String[1] $bk_dir = "/Users/${user}/.buildkite-agent",
  String[1] $label = "com.buildkite.buildkite-agent-${bk_name}",
  String[1] $launchagents_path = "/Users/${user}/Library/LaunchAgents",
  String[1] $plist_path = "${launchagents_path}/${label}.plist",
  String[1] $config_path = "${bk_dir}/${label}.cfg",
  String[1] $bin_path = '/usr/local/bin/buildkite-agent',
  String[1] $path = '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin',
  String[1] $stdout_path = "${bk_dir}/log/buildkite-agent.log",
  String[1] $stderr_path = "${bk_dir}/log/buildkite-agent.log",
  Boolean $allow_clean_exit = false,
  Boolean $debug = false,
  Boolean $run_at_load = true,
  Boolean $interactive = false,
  Integer $throttle_interval = 30,
) {

  file { [dirname($bk_dir), "${bk_dir}/log"]:
    ensure => directory,
  }

  $debug_arg = $debug ? {
    true  => '--debug',
    false => '',
  }

  $keep_alive = $allow_clean_exit ? {
    true  => { 'SuccessfulExit' => false },
    false => true,
  }

  $process_type = $interactive ? {
    true  => 'Interactive',
    false => 'Standard',
  }

  $data = {
    'EnvironmentVariables' => {
      'BUILDKITE_AGENT_CONFIG' => $config_path,
      'PATH'                   => $path,
    },
    'KeepAlive'            => $keep_alive,
    'Label'                => $label,
    'ProcessType'          => $process_type,
    'ProgramArguments'     => [
      $bin_path,
      'start',
      $debug_arg,
    ],
    'RunAtLoad'            => $run_at_load,
    'StandardErrorPath'    => $stderr_path,
    'StandardOutPath'      => $stdout_path,
    'ThrottleInterval'     => $throttle_interval,
  }

  file { $plist_path:
    ensure  => present,
    content => hash2plist($data),
  }

  exec { "reload_job_${label}":
    command     => "/bin/launchctl unload -w ${plist_path} && /bin/launchctl load -w ${plist_path}",
    subscribe   => File[$plist_path, '/usr/local/bin/buildkite-agent'],
    refreshonly => true,
  }

  if $ensure == 'running' {
    exec { "ensure_job_running_${label}":
      command => "/bin/launchctl load -w ${plist_path}",
      unless  => "/bin/launchctl list | /usr/bin/grep ${label}",
      require => File[$plist_path],
    }
  } else {
    exec { "ensure_job_stopped_${label}":
      command => "/bin/launchctl load -w ${plist_path}",
      onlyif  => "/bin/launchctl list | /usr/bin/grep ${label}",
      require => File[$plist_path],
    }
  }

}
