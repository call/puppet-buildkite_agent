# buildkite_agent

:warning: This module is in active development.

A Puppet module to manage Buildkite Agent services on macOS nodes.

## Table of Contents

- [buildkite_agent](#buildkiteagent)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [What buildkite_agent affects](#what-buildkiteagent-affects)
    - [Setup Requirements](#setup-requirements)
    - [Beginning with buildkite_agent](#beginning-with-buildkiteagent)
  - [Usage](#usage)
  - [Reference](#reference)
  - [Limitations](#limitations)
  - [Development](#development)
  - [Release Notes/Contributors/Etc. **Optional**](#release-notescontributorsetc-optional)

## Description

Buildkite Agent is a small Go binary used to run jobs from [Buildkite](https://buildkite.com). A single physical or virtual host can run multiple, independently configured Buildkite Agent services.

This module is designed for use with Hiera. Settings for Buildkite Agent services can be defined as Hiera hashes, providing a data-driven mechanism for managing complex configurations of multiple Buildkite Agents.

This module currently supports only macOS.

## Setup

### What buildkite_agent affects

- Download and installation `buildkite-agent` binary from GitHub release tarball
- Management of one or more Buildkite Agent configuration files
- Management of one or more Buildkite Agent `launchd` jobs

### Setup Requirements

This module depends on the `puppetlabs/stdlib` and `puppet/archive` modules.

### Beginning with buildkite_agent

```puppet
include buildkite_agent
```

## Usage

:warning: This section is incomplete.

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

:warning: This section is incomplete.

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the root of your module directory and list out each of your module's classes, defined types, facts, functions, Puppet tasks, task plans, and resource types and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

- The data type, if applicable.
- A description of what the element does.
- Valid values, if the data type doesn't make it obvious.
- Default value, if any.

For example:

```bash
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

:warning: This section is incomplete.

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Development

:warning: This section is incomplete.

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

:warning: This section is incomplete.

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
