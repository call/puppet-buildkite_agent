# buildkite_agent

:warning: This module is in active development.

A Puppet module to manage Buildkite Agent services on macOS nodes.

#### Table of Contents

- [buildkite_agent](#buildkiteagent)
      - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [What buildkite_agent affects **OPTIONAL**](#what-buildkiteagent-affects-optional)
    - [Setup Requirements **OPTIONAL**](#setup-requirements-optional)
    - [Beginning with buildkite_agent](#beginning-with-buildkiteagent)
  - [Usage](#usage)
  - [Reference](#reference)
  - [Limitations](#limitations)
  - [Development](#development)
  - [Release Notes/Contributors/Etc. **Optional**](#release-notescontributorsetc-optional)

## Description

Buildkite Agent is a small Go binary used to run Buildkite jobs. A single physical or virtual host can run multiple, independently configured Buildkite Agent services. This module is designed for use with Hiera. Settings for Buildkite Agent services can be defined as Hiera hashes, providing a data-driven mechanism for managing complex configurations of multiple Buildkite Agents.

This module currently supports only macOS.

## Setup

### What buildkite_agent affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For example, folks can probably figure out that your mysql_instance module affects their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* Files, packages, services, or operations that the module will alter, impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled, another module, etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps for upgrading, you might want to include an additional "Upgrading" section here.

### Beginning with buildkite_agent

The very basic steps needed for a user to get the module up and running. This can include setup steps, if necessary, or it can be an example of the most basic use of the module.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the root of your module directory and list out each of your module's classes, defined types, facts, functions, Puppet tasks, task plans, and resource types and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
