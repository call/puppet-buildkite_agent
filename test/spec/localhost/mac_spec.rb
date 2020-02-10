require 'spec_helper'

set :backend, :exec

USER=(`ac -p`.split(/\n/).map { |l| l.strip!.split(/\s{2,}/) }.sort_by { |a| a.last.to_f })[-2][0]

describe service('com.buildkite.buildkite-agent-primary') do
  # it { should be_running } # TODO: This is incorrectly using `ps aux` to look for service
  # it { should be_running.under('launchd') } # This gets us closer but not quite
  it { should be_enabled } # This works
end

# Workaround to check for running launchd job
describe command('launchctl list | grep com.buildkite.buildkite-agent-primary') do
  its(:exit_status) { should eq 0 }
end

describe file('/usr/local/bin/buildkite-agent') do
  it { should be_executable }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'admin' }
  it { should be_mode 755 }
end

describe file("/Users/#{USER}/.buildkite-agent") do
  it { should be_directory }
  it { should be_owned_by "#{USER}" }
  it { should be_grouped_into 'staff' }
  it { should be_mode 755 }
end

describe file("/Users/#{USER}/.buildkite-agent/log") do
  it { should be_directory }
  it { should be_owned_by "#{USER}" }
  it { should be_grouped_into 'staff' }
  it { should be_mode 755 }
end

describe file("/Users/#{USER}/.buildkite-agent/builds") do
  it { should be_directory }
  it { should be_owned_by "#{USER}" }
  it { should be_grouped_into 'staff' }
  it { should be_mode 755 }
end

describe file("/Users/#{USER}/.buildkite-agent/hooks") do
  it { should be_directory }
  it { should be_owned_by "#{USER}" }
  it { should be_grouped_into 'staff' }
  it { should be_mode 755 }
end

describe file("/Users/#{USER}/.buildkite-agent/log/buildkite-agent.log") do
  it { should be_file }
  it { should be_owned_by "#{USER}" }
  it { should be_grouped_into 'staff' }
  it { should be_mode 644 }
end

describe file("/Users/#{USER}/.buildkite-agent/buildkite-agent.cfg") do
  it { should be_file }
  it { should be_owned_by "#{USER}" }
  it { should be_grouped_into 'staff' }
  it { should be_mode 644 }
end
