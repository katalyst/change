def quiet_system(command)
  system("#{command} > /dev/null 2>&1")
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
  quiet_system("git push #{remote} #{branch}")
end

def setup
  @root_dir = Dir.pwd
end

def common_setup(name_a, name_b=nil)
  setup
  create_bare_repo("origin")
  create_repo(name_a)
  create_and_commit("README")
  add_remote("origin")
  push_branch("origin", "master")
  if name_b
    clone_repo("origin", name_b)
    change_repo(name_a)
  end
end
