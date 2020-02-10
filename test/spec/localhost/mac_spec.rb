require 'spec_helper'

set :backend, :exec

describe service('com.buildkite.buildkite-agent-primary'), :if => os[:family] == 'darwin', :sudo => true do
  it { should be_enabled }
  it { should be_running }
end
