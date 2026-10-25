# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.8.0/whatnow-darwin-arm64"
    sha256 "503e8bc6afcc546f3d3c3ea37d9b4af6729cf55e6614755a9489eefd9df495ad"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.8.0/whatnow-darwin-amd64"
    sha256 "665952b1730632b1a7007b32c65a8a03ba3adcc7d652e1f577c797820bba2059"
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
