require_relative "support/helpers"

setup("origin", "user_a")
change_repo("user_a")
run("change start foo")
run("change start bar")
run("change checkout foo")

if `git branch --no-color`.match(/^\s*\*\s*(.+)\s*$/)[1].strip != "change/foo"
  raise "Expected `change checkout foo` to checkout the 'change/foo' branch."
end
