require_relative "support/helpers"

setup("origin", [ "user_a", "user_b" ])
change_repo("user_a")
run("change start example-a")
create_and_commit("example_a")
run("change publish")
change_repo("user_b")
run("git fetch")
run("change checkout example-a")

if `ls -m`.split(",").collect(&:strip).grep("example_a").empty?
  raise "Expected `change publish` to push changes to the remote."
end
