require_relative "support/helpers"

setup("origin", "user_a")
change_repo("user_a")
quiet_system("change start foo")
create_and_commit("abc")

result = `change accept --complete`

if result.split(",").collect(&:strip) != ["foo"]
  raise "Expected `change accept --complete` to list all changes."
end
