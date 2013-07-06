def verbose?
  (verbose == true) || ARGV.include?("--verbose") || ARGV.include?("-v")
end

def quiet_system(command)
  if verbose?
    system(command)
  else
    system("#{command} > /dev/null 2>&1")
  end
end

def change_repo(name)
  Dir.chdir(File.join(@root_dir, name))
end

def create_repo(name)
  path = File.join(@root_dir, name)
  Dir.mkdir(path)
  Dir.chdir(path)
  quiet_system("git init")
end

def create_bare_repo(name)
  path = File.join(@root_dir, name)
  Dir.mkdir(path)
  Dir.chdir(path)
  quiet_system("git init --bare")
end

def clone_repo(remote, name)
  repo_path = File.join(@root_dir, name)
  remote_path = File.join(@root_dir, remote)
  quiet_system("git clone #{remote_path} #{repo_path}")
  Dir.chdir(repo_path)
end

def create_and_commit(file)
  quiet_system("touch #{file}")
  quiet_system("git add #{file}")
  quiet_system("git commit -m '#{file}'")
end

def add_remote(remote)
  path = File.join(@root_dir, remote)
  system "git remote add #{remote} #{path}"
end

def push_branch(remote, branch)
  quiet_system("git pull #{remote} #{branch}")
  quiet_system("git push -u #{remote} #{branch}")
end

def setup(remotes=[], locals=[])

  return setup([remotes], locals) unless remotes.is_a?(Array)
  return setup(remotes, [locals]) unless locals.is_a?(Array)

  @root_dir = Dir.pwd

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

  Dir.chdir(@root_dir)

end
