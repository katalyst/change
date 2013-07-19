def verbose?
  (verbose == true) || ARGV.include?("--verbose") || ARGV.include?("-v")
end

def run(command)
  if verbose?
    `command`
  else
    `#{command} > /dev/null 2>&1`
  end
end

alias quiet_system run

def change_repo(name)
  Dir.chdir(File.join(ENV["TEST_DIR"], name))
end

def create_repo(name, options={})
  path = File.join(ENV["TEST_DIR"], name)
  Dir.mkdir(path)
  Dir.chdir(path)
  if options[:bare]
    run("git init --bare")
  else
    run("git init")
  end
end

def create_bare_repo(name)
  create_repo(name, :bare => true)
end

def clone_repo(remote, name)
  repo_path = File.join(ENV["TEST_DIR"], name)
  remote_path = File.join(ENV["TEST_DIR"], remote)
  quiet_system("git clone #{remote_path} #{repo_path}")
  Dir.chdir(repo_path)
end

def create_and_commit(file)
  quiet_system("touch #{file}")
  quiet_system("git add #{file}")
  quiet_system("git commit -m '#{file}'")
end

def add_remote(remote)
  path = File.join(ENV["TEST_DIR"], remote)
  system "git remote add #{remote} #{path}"
end

def push_branch(remote, branch)
  quiet_system("git pull #{remote} #{branch}")
  quiet_system("git push -u #{remote} #{branch}")
end

def setup(remotes=[], locals=[])

  return setup([remotes], locals) unless remotes.is_a?(Array)
  return setup(remotes, [locals]) unless locals.is_a?(Array)

  ENV["TEST_DIR"] ||= Dir.pwd

  remotes.each do |remote|
    create_bare_repo(remote)
  end

  locals.each do |local|
    create_repo(local)
    create_and_commit(local)
    remotes.each do |remote|
      add_remote(remote)
      push_branch(remote, "master")
    end
  end

  Dir.chdir(ENV["TEST_DIR"])

end
