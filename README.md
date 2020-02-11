# buildkite_agent

A Puppet module to manage [Buildkite Agent](https://buildkite.com/docs/agent/v3) on macOS. :apple:

## Table of Contents

- [buildkite_agent](#buildkiteagent)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [Beginning with buildkite_agent](#beginning-with-buildkiteagent)
  - [Usage](#usage)
  - [Limitations](#limitations)
  - [Development](#development)
  - [Testing](#testing)
  - [GitHub Actions](#github-actions)

## Description

Buildkite Agent (`buildkite-agent`) is a small Go binary that runs [Buildkite](https://buildkite.com) jobs.

The `buildkite_agent` Puppet module:

- Installs `buildkite-agent` from GitHub [release](https://github.com/buildkite/agent/releases) tarball
- Manages Buildkite Agent [config files and settings](https://buildkite.com/docs/agent/v3/configuration)
- Manages Buildkite Agent user [LaunchAgents](https://github.com/buildkite/agent/blob/master/templates/launchd_local_with_gui.plist) ([launchd](https://www.launchd.info/) jobs)

Classes and defined types use default parameter values sourced from Buildkite's [macOS agent documentation](https://buildkite.com/docs/agent/v3/osx).

This module currently supports __macOS only__.

## Setup

### Beginning with buildkite_agent

Setting the `token` parameter is the only requirement to get up and running.

```puppet
class { 'buildkite_agent':
  token => '757613ad20dfaf9b7b4b37d0b4ed4b6c',
}
```

Replace the value for `token` with your Buildkite [Agent Token](https://buildkite.com/docs/agent/v3/tokens).

## Usage

To run a single Buildkite Agent with the default LaunchAgent label of `com.buildkite.buildkite-agent-primary`, use the example above (with your own token).

:bulb:  If `buildkite_agent::config::user` or `buildkite_agent::service::user` are unspecified, the user with greatest login time, as determined by the custom fact `lib/facter/primary_user.rb`, will be used as the default.

TODO: Add advanced usage examples

## Limitations

This module only supports macOS, and has only been tested on macOS Catalina (10.15).

## Development

TODO: Figure out how to safely accept public contributions with GitHub Actions + PRs

## Testing

This module is tested using the following steps:

- Install `puppet-agent` and this module in a GitHub Actions macOS environment
- Run `puppet apply` (2x) to check that desired state is configured and maintained
- Validate configuration with [Serverspec](https://serverspec.org/) tests (located in the `test/` directory)

GitHub Actions macOS virtual environments are hosted on [MacStadium](https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#cloud-hosts-for-github-hosted-runners) and contain some [preconfigured software](https://help.github.com/en/actions/reference/software-installed-on-github-hosted-runners#macos-1015).

TODO: Add Puppet spec tests

## GitHub Actions

Two [GitHub Actions](https://help.github.com/en/actions) workflows are used in the development and publishing of this module. GitHub Actions workflows are located in the `.github/workflows/` directory .

- `forge_publish.yml`
  - Triggered when a [SemVer](https://semver.org/)-style tag is pushed on any branch
  - Run all Puppet Development Kit (PDK) [validations](https://puppet.com/docs/pdk/1.x/pdk_testing.html#validate-module) against this repository
  - Run `pdk build` to [build the module package](https://puppet.com/docs/pdk/1.x/pdk_building_module_packages.html)
  - Publish module package to the [Puppet Forge](https://forge.puppet.com/) using the [Forge API](https://puppet.com/blog/new-forge-api-endpoints-automating-module-management/)
    - `FORGE_API_KEY` must be set as a GitHub Actions [encrypted secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets)
- `macos_pupet_apply.yml`
  - Triggered on every push
  - Install `puppet-agent-6` from package at downloads.puppet.com/mac/puppet6/10.14/x86_64/
  - Build the module package from source with `tar`
  - Install the module with `sudo puppet module install`
  - Run `puppet apply -e` (2x) to [execute inline code](https://www.puppetcookbook.com/posts/simple-adhoc-execution-with-apply-execute.html) declaring the `buildkite_agent` class
    - `BUILDKITE_AGENT_TOKEN` must be provided as a GitHub Actions encrypted secret
  - Install Serverspec gem
  - Run Serverspec tests
