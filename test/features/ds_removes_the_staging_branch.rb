require_relative "support/helpers"

setup("origin", "user_a")
change_repo("user_a")
run("change start bar")
create_and_commit("example")
run("change stage")
run("change accept")
run("change ds")

unless `git branch --no-color`.lines.collect(&:strip).grep(%r{^(\*\s+)?staging$}).empty?
  raise "Expected `change ds` to remove a fully merged staging branch."
end
