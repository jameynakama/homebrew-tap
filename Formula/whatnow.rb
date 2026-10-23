# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.7.0/whatnow-darwin-arm64"
    sha256 "80c98dbbf3aa18390875c268f5918e7cd04d85fc3759327238d0a5d24b34b281"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.7.0/whatnow-darwin-amd64"
    sha256 "83dbbd229c1534dd2da0657070be9b8b802834181a05d0f6e2c5b1e8d81b8477"
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
