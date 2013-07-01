common_setup("user_a")

quiet_system("change start foo")
create_and_commit("abc")
quiet_system("change accept")
quiet_system("git checkout master")

if `ls -m`.split(",").collect(&:strip).grep("abc").empty?
  raise "Expected `change accept` to merge the current change into master."
end
