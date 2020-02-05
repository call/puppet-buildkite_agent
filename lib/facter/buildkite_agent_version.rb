require 'mkmf'

# Silences mkmf
module MakeMakefile::Logging
  @logfile = File::NULL
  @quiet = true
end

Facter.add(:buildkite_agent_version) do
  confine kernel: ['Darwin']
  setcode do
    if find_executable 'buildkite-agent'
      `buildkite-agent --version`.split(' ')[2].chomp(',')
    end
  end
end
