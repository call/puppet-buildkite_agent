# Credit to pmbuko and dayglojesus
# https://gist.github.com/pmbuko/c7ca70f2ffc5378047ef
#
# Obfuscated with Ruby
# needs to split on 2 or more whitespace to handle user names with spaces
Facter.add(:primary_user) do
  confine :kernel => ['Darwin', 'Linux']
  setcode do
    (`ac -p`.split(/\n/).map { |l| l.strip!.split(/\s{2,}/) }.sort_by { |a| a.last.to_f })[-2][0]
  end
end
