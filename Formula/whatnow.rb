# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.5.0/whatnow-darwin-arm64"
    sha256 "8d135705310e76210431f1f8de93a78807e33ac9a0ff3076f6cbd98f17e35b60"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.5.0/whatnow-darwin-amd64"
    sha256 "2702cedeaa70f5121bfe84288dd8a6882ec7ad39dd9d8e5315a38dc17106ef25"
  end
  license "MIT"

  depends_on :macos

  def install
    bin.install Dir["whatnow-darwin-*"].first => "whatnow"
  end

  service do
    run [opt_bin/"whatnow", "serve"]
    keep_alive true
    log_path var/"log/whatnow.log"
    error_log_path var/"log/whatnow.log"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/whatnow version").strip
  end
end
