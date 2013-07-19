require_relative "support/helpers"

setup("origin", "user_a")
change_repo("user_a")
run("change start bar")
create_and_commit("example")
run("change stage")
run("change ds -f")

unless `git branch --no-color`.lines.collect(&:strip).grep(%r{^(\*\s+)?staging$}).empty?
  raise "Expected `change ds -f` to forcefully remove an unmerged staging branch."
end
