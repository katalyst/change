class DirtyHeadError < StandardError
  def initialize(message=nil)
    super(message || "HEAD is dirty. Stash your changes and try again.")
  end
end

def run_or_raise(command, error=nil)

  system("tput setaf 6")
  puts "$ #{command}"
  system("tput setaf 7")

  unless system(command)
    raise (error || "Unknown error.")
  end

end

def handle_error(error)

  system("tput setaf 1")
  puts error
  system("tput setaf 7")

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
  system("tput setaf 7")
end

def head_is_clean
  `git status --porcelain`.strip.empty?
end

def on_branch(branch)
  `git branch --no-color` =~ /^\s*\*\s*#{Regexp.escape(branch)}\s*$/
end

def has_branch(branch)
  `git branch -a --no-color` =~ /^[\*\s]*#{Regexp.escape(branch)}\s*$/
end

def current_branch
  `git branch --no-color`.match(/^\s*\*\s*(.+)\s*$/)[1].strip
end
