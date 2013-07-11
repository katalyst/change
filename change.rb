require 'formula'

class Change < Formula

  homepage 'https://github.com/ketchup/change'
  url 'https://github.com/ketchup/change/zipball/v1.3.0'
  sha1 '3212677aeb50293da04656ec37108164a2e2a549'

  def test
    system "change"
  end

  def install
    bin.install 'bin/change' => 'change'
    prefix.install Dir["libexec", "share", "VERSION"]
    bash_completion.install "completions/change.bash"
    zsh_completion.install 'completions/change.zsh' => '_change'
  end

end
