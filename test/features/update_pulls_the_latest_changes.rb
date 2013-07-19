require_relative "support/helpers"

setup("origin", [ "user_a", "user_b" ])

change_repo("user_a")
run("change start example-a")
create_and_commit("foo_1")
run("change publish")

change_repo("user_b")
run("git fetch")
run("change checkout example-a")
create_and_commit("foo_2")
run("change publish")

change_repo("user_a")
run("change checkout example-a")
run("change update")

if `ls -m`.split(",").collect(&:strip).grep("foo_2").empty?
  raise "Expected `change update` to pull the latest changes."
end
