require_relative "support/helpers"

setup("origin", "user_a")
change_repo("user_a")
run("change start bar")
run("change delete bar")

unless `git branch`.lines.collect(&:strip).grep(%r{^(\*\s+)?change/bar$}).empty?
  raise "Expected `change delete bar` to remove the full-merged 'change/bar' branch."
end
