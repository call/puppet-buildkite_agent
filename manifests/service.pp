# @summary Manages launchd jobs for buildkite-agent.
#
# Creates and ensures state of LaunchAgents
#
# @example
#   buildkite_agent::service { 'namevar': }
define buildkite_agent::service (
  String[1] $user                    = $facts['primary_user'],
  String[1] $bk_name                 = $name, # Instance namevar
  Enum['stopped', 'running'] $ensure = 'running',
  String[1] $label                   = "com.buildkite.buildkite-agent-${bk_name}",
  String[1] $bk_dir                  = "/Users/${user}/.buildkite-agent",
  String[1] $plist_path              = "/Users/${user}/Library/LaunchAgents/${label}.plist",
  String[1] $config_path             = "${bk_dir}/buildkite-agent.cfg",
  String[1] $bin_path                = '/usr/local/bin/buildkite-agent',
  String[1] $path                    = '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin',
  String[1] $stdout_path             = "${bk_dir}/log/buildkite-agent.log",
  String[1] $stderr_path             = "${bk_dir}/log/buildkite-agent.log",
  Boolean $allow_clean_exit          = false,
  Boolean $debug                     = false,
  Boolean $run_at_load               = true,
  Boolean $interactive               = false,
  Integer $throttle_interval         = 30,
) {

  $program_args = $debug ? {
    true  => [$bin_path, 'start', '--debug'],
    false => [$bin_path, 'start'],
  }

  $keep_alive = $allow_clean_exit ? {
    true  => {'SuccessfulExit' => false},
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
    'ProgramArguments'     => $program_args,
    'RunAtLoad'            => $run_at_load,
    'StandardErrorPath'    => $stderr_path,
    'StandardOutPath'      => $stdout_path,
    'ThrottleInterval'     => $throttle_interval,
  }

  file { $plist_path:
    ensure  => present,
    owner   => $user,
    group   => 'staff',
    mode    => '0644',
    content => hash2plist($data),
  }

  # Execs to manage LaunchAgents per-user, this is not supported by the launchd provider
  # https://tickets.puppetlabs.com/browse/PUP-1261
  exec { "reload_job_${label}":
    command     => "/usr/bin/sudo -H -u ${user} /bin/bash -c '/bin/launchctl unload -w ${plist_path} && /bin/launchctl load -w ${plist_path}'",
    subscribe   => File[$plist_path, $bin_path],
    refreshonly => true,
  }

  if $ensure == 'running' {
    exec { "ensure_job_running_${label}":
      command => "/usr/bin/sudo -H -u ${user} /bin/bash -c '/bin/launchctl load -w ${plist_path}'",
      unless  => "/bin/launchctl list | /usr/bin/grep ${label}",
      require => File[$plist_path],
    }
  } else {
    exec { "ensure_job_stopped_${label}":
      command => "/usr/bin/sudo -H -u ${user} /bin/bash -c '/bin/launchctl unload -w ${plist_path}'",
      onlyif  => "/usr/bin/sudo -H -u ${user} /bin/bash -c '/bin/launchctl list | /usr/bin/grep ${label}'",
      require => File[$plist_path],
    }
  }

}
