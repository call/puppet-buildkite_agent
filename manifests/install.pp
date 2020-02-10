# @summary Installs Buildkite agent
#
# Installs the buildkite-agent binary on macOS
#
# @example
#   include buildkite_agent::install
class buildkite_agent::install (
  String[1] $package_name,
  String[1] $package_ensure,
  String[1] $repository_url,
  String[1] $bin_path,
  String[1] $archive_name = "${package_name}-${package_ensure}.tar.gz",
  String[1] $package_source = "${repository_url}/v${package_ensure}/${archive_name}",
  String[1] $user = $facts['primary_user'],
  Optional[Hash[String, Hash[String, String]]] $files,
) {

  if $files {
    $defaults = {
      'owner'  => $user,
      'group'  => 'staff',
      'mode'   => '0755',
    }

    create_resources(file, $files, $defaults)
  }

  if $facts['buildkite_agent_version'] and
    (versioncmp($facts['buildkite_agent_version'], $package_ensure) == 0) {
    notify{ "Buildkite-agent ${package_ensure} is installed as specified.": }
  } else {
    notify{ "Buildkite-agent ${package_ensure} not installed, installing...": }

    file { "/tmp/${archive_name}-untar":
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
      command     => "/bin/cp /tmp/${archive_name}-untar/buildkite-agent ${bin_path}",
      subscribe   => Archive[$archive_name],
      refreshonly => true,
      before      => File[$bin_path],
    }
  }

}
