require_relative "support/helpers"

setup("origin", "user_a")
change_repo("user_a")
run("change start example-a")
create_and_commit("example_a")
run("change stage")
run("git checkout staging")

if `ls -m`.split(",").collect(&:strip).grep("example_a").empty?
  raise "Expected `change stage` to add a change to the staging branch."
end
