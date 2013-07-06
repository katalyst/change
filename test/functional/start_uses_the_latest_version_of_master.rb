require_relative "support/helpers"

setup("origin", [ "user_a", "user_b" ])
change_repo("user_b")
create_and_commit("foo")
push_branch("origin", "master")
change_repo("user_a")
create_and_commit("foo2")
quiet_system("change start bar")

if `ls -m`.split(",").collect(&:strip).grep("foo").empty?
  raise "Expected `change start bar` to use the latest version of the master branch."
end
