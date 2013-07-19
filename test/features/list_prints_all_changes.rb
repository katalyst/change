require_relative "support/helpers"

setup("origin", [ "user_a", "user_b" ])
change_repo("user_a")
run("change start example-a")
create_and_commit("example_a")
run("change publish")
change_repo("user_b")
run("change start example-b")
create_and_commit("example_b")

result = `change list`

if result.lines.collect(&:strip).sort != [ "example-a", "example-b" ]
  raise "Expected `change list` to list all changes."
end
