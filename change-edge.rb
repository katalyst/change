require 'formula'

class ChangeEdge < Formula

  homepage 'https://github.com/katalyst/change'
  url 'https://github.com/katalyst/change/zipball/v1.3.0'
  sha1 'cd14f8688f07f7089929f3c1d48a27035485f295'

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
