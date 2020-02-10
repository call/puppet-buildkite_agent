require 'spec_helper'

set :backend, :exec

describe service('com.buildkite.buildkite-agent-primary'), :if => os[:family] == 'darwin' do
  # it { should be_running } # TODO: This is incorrectly using ps aux to look for service
  # it { should be_running.under('launchd') } This gets us closer but not correct...
  it { should be_enabled }
end

# This handles checking the service is running as a workaround
describe command('launchctl list | grep com.buildkite.buildkite-agent-primary') do
  its(:exit_status) { should eq 0 }
end

describe file('/usr/local/bin/buildkite-agent') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'admin' }
  it { should be_mode 755 }
end