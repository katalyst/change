require_relative "support/helpers"

setup("origin", "user_a")
change_repo("user_a")
quiet_system("change start foo")

if `git branch`.lines.collect(&:strip).grep(%r{^(\*\s+)?change/foo$}).empty?
  raise "Expected `change start foo` to make a branch called 'change/foo'."
end
