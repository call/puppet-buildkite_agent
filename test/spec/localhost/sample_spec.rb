require 'spec_helper'

set :backend, :exec

describe service('com.buildkite.buildkite-agent-primary'), :if => os[:family] == 'darwin', :sudo => true do
  it { should be_enabled }
end

describe service('com.buildkite.buildkite-agent-secondary'), :if => os[:family] == 'darwin', :sudo => true do
  it { should be_enabled }
end

# describe service('buildkite-agent start'), :if => os[:family] == 'darwin', :sudo => true do
#   it { should be_running }
# end

describe port(17600) do
  it { should be_listening }
end
