# @summary Manages buildkite-agent configuration.
#
# Manages a Buildkite agent config file
#
# @example
#   buildkite_agent::config { 'namevar': }
define buildkite_agent::config (
  String[1] $config_file_path = '/usr/local/etc/buildkite-agent/buildkite-agent.cfg',
  Optional[String] $bootstrap_script = undef,
  Optional[String] $build_path = undef,
  Optional[String] $cancel_grace_period = undef,
  Optional[String] $cancel_signal = undef,
  Optional[String] $debug = undef,
  Optional[String] $debug_http = undef,
  Optional[String] $disconnect_after_job = undef,
  Optional[String] $disconnect_after_idle_timeout = undef,
  Optional[String] $endpoint = undef,
  Optional[String] $experiment = undef,
  Optional[String] $git_clean_flags = undef,
  Optional[String] $git_clone_flags = undef,
  Optional[String] $git_clone_mirror_flags = undef,
  Optional[String] $git_fetch_flags = undef,
  Optional[String] $git_mirrors_lock_timeout = undef,
  Optional[String] $git_mirrors_path = undef,
  Optional[String] $health_check_addr = undef,
  Optional[String] $hooks_path = undef,
  Optional[String] $log_format = undef,
  Optional[String] $metrics_datadog = undef,
  Optional[String] $metrics_datadog_host = undef,
  Optional[String] $bk_name = undef,
  Optional[String] $no_color = undef,
  Optional[String] $no_command_eval = undef,
  Optional[String] $no_git_submodules = undef,
  Optional[String] $no_http2 = undef,
  Optional[String] $no_local_hooks = undef,
  Optional[String] $no_plugins = undef,
  Optional[String] $no_plugin_validation = undef,
  Optional[String] $no_pty = undef,
  Optional[String] $no_ssh_keyscan = undef,
  Optional[String] $plugins_path = undef,
  Optional[String] $priority = undef,
  Optional[String] $shell = undef,
  Optional[String] $spawn = undef,
  Optional[String] $tags = undef,
  Optional[String] $tags_from_ec2 = undef,
  Optional[String] $tags_from_ec2_tags = undef,
  Optional[String] $tags_from_gcp = undef,
  Optional[String] $tags_from_gcp_labels = undef,
  Optional[String] $tags_from_host = undef,
  Optional[String] $timestamp_lines = undef,
  Optional[String] $wait_for_ec2_tags_timeout = undef,
  Optional[String] $wait_for_gcp_labels_timeout = undef,
) {

  file { dirname($config_file_path):
    ensure => directory,
  }

  file { $config_file_path:
    ensure => file,
  }

  $settings = {
    'bootstrap-script'              => $bootstrap_script,
    'build-path'                    => $build_path,
    'cancel-grace-period'           => $cancel_grace_period,
    'cancel-signal'                 => $cancel_signal,
    'debug'                         => $debug,
    'debug-http'                    => $debug_http,
    'disconnect-after-job'          => $disconnect_after_job,
    'disconnect-after-idle-timeout' => $disconnect_after_idle_timeout,
    'endpoint'                      => $endpoint,
    'experiment'                    => $experiment,
    'git-clean-flags'               => $git_clean_flags,
    'git-clone-flags'               => $git_clone_flags,
    'git-clone-mirror-flags'        => $git_clone_mirror_flags,
    'git-fetch-flags'               => $git_fetch_flags,
    'git-mirrors-lock-timeout'      => $git_mirrors_lock_timeout,
    'git-mirrors-path'              => $git_mirrors_path,
    'health-check-addr'             => $health_check_addr,
    'hooks-path'                    => $hooks_path,
    'log-format'                    => $log_format,
    'metrics-datadog'               => $metrics_datadog,
    'metrics-datadog-host'          => $metrics_datadog_host,
    'name'                          => $bk_name,
    'no-color'                      => $no_color,
    'no-command-eval'               => $no_command_eval,
    'no-git-submodules'             => $no_git_submodules,
    'no-http2'                      => $no_http2,
    'no-local-hooks'                => $no_local_hooks,
    'no-plugins'                    => $no_plugins,
    'no-plugin-validation'          => $no_plugin_validation,
    'no-pty'                        => $no_pty,
    'no-ssh-keyscan'                => $no_ssh_keyscan,
    'plugins-path'                  => $plugins_path,
    'priority'                      => $priority,
    'shell'                         => $shell,
    'spawn'                         => $spawn,
    'tags'                          => $tags,
    'tags-from-ec2'                 => $tags_from_ec2,
    'tags-from-ec2-tags'            => $tags_from_ec2_tags,
    'tags-from-gcp'                 => $tags_from_gcp,
    'tags-from-gcp-labels'          => $tags_from_gcp_labels,
    'tags-from-host'                => $tags_from_host,
    'timestamp-lines'               => $timestamp_lines,
    'wait-for-ec2-tags-timeout'     => $wait_for_ec2_tags_timeout,
    'wait-for-gcp-labels-timeout'   => $wait_for_gcp_labels_timeout,
  }

  $settings.each |String $key, Optional[String] $val| {
    if $val {
      file_line { "setting_${key}":
        path => $config_file_path,
        line => "${key}=${val}",
      }
    }

  }

}


