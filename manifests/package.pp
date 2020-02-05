# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include buildkite_agent::package
class buildkite_agent::package (
  String[1] $token = 'FOOTOKEN',
  Boolean $beta = false,
) {

  $package_name        = 'buildkite-agent-darwin-amd64'
  $package_ensure      = '3.19.0'
  $repository_url      = 'https://github.com/buildkite/agent/releases/download/'
  $archive_name        = "${package_name}-${package_ensure}.tar.gz"
  $package_source = "${repository_url}/v${package_ensure}/${archive_name}"

  if $facts['buildkite_agent_version'] and (versioncmp($facts['buildkite_agent_version'], $package_ensure) == 0) {
    notify{ "Buildkite-agent ${package_ensure} is installed as specified.": }
  } else {
    notify{ 'Buildkite-agent not present or different version than specified, installing...': }

    file {"/tmp/${archive_name}-untar":
      ensure => directory,
    }

    archive { $archive_name:
      path         => "/tmp/${archive_name}",
      source       => $package_source,
      extract      => true,
      extract_path => "/tmp/${archive_name}-untar",
      cleanup      => false,
    }

    exec { 'cp_buildkite_agent':
      command     => "/bin/cp /tmp/${archive_name}-untar/buildkite-agent /usr/local/bin/buildkite-agent",
      subscribe   => Archive[$archive_name],
      refreshonly => true,
      before      => File['/usr/local/bin/buildkite-agent'],
    }

    file { '/usr/local/bin/buildkite-agent':
      ensure => 'present',
      owner  => 'root',
      group  => 'admin',
      mode   => '0755',
    }

  }

}
