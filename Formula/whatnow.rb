# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.10.0/whatnow-darwin-arm64"
    sha256 "db3ea82f88452de726e13dc089e6f6ae30397c9b81e587d93eccb0aa020e3e82"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.10.0/whatnow-darwin-amd64"
    sha256 "44040ef8b71024c274fee76219265dd6def73593aa07abcb8cb041160fb76cd4"
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
