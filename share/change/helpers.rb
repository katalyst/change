# errors

class DirtyHeadError < StandardError
  def initialize(message=nil)
    super(message || "HEAD is dirty. Stash your changes and try again.")
  end
end

# core

def run_or_raise(command, error=nil)

  system("tput setaf 6")
  puts "$ #{command}"
  system("tput sgr0")

  unless system(command)
    raise (error || "Unknown error.")
  end

end

def handle_error(error)

  system("tput setaf 1")
  puts error
  system("tput sgr0")

  status = case error
    when ArgumentError:   1
    when DirtyHeadError:  2
    else -1
  end

  exit(status)

end

def extract_string_option(args, name)
  while i = args.index(name)
    args.delete_at(i)
    out = args.delete_at(i)
  end
  out
end

def put_success(message)
  system("tput setaf 2")
  puts message
  system("tput sgr0")
end

# git

def head_is_clean?
  `git status --porcelain`.strip.empty?
end

alias head_is_clean head_is_clean?

def on_branch?(branch)
  current_branch == branch
end

alias on_branch on_branch?

def has_branch?(branch)
  all_branches.include?(branch)
end

alias has_branch has_branch?

def current_branch
  `git rev-parse --abbrev-ref HEAD`.strip
end

def all_branches
  branches = []
  branches << `git branch --no-color`.lines.collect do |branch|
    branch[%r{^([\*\s]*)(.*)(\s*)$}, 2]
  end
  branches << `git branch --remote --no-color`.lines.collect do |branch|
    branch[%r{^([\*\s]*)(.+?/)(.*)(\s*)$}, 3]
  end
  branches.flatten.uniq.sort
end

# change

def is_change_branch?(branch)
  all_change_branches.include?(branch)
end

def all_change_branches
  all_branches.select { |b| !!b["/"] }
end

def all_change_names
  all_change_branches.collect do |branch|
    change_name_from_branch(branch)
  end
end

def change_branches_named(name)
  all_change_branches.select do |branch|
    branch[%r{^(.+?/)(.+)$}, 2] == name
  end
end

def change_name(branch)
  branch[%r{^(.+?/)(.+)$}, 2]
end

alias name_from_branch change_name
