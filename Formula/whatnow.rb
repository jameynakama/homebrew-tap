# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.13.0/whatnow-darwin-arm64"
    sha256 "025507e8e64887985252deb5873813f0f8f588f06c4a93fbd4c1aa41279725f0"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.13.0/whatnow-darwin-amd64"
    sha256 "94643ddf783349cf002db51942bd3b3cf7a8b3c8ec695d24a6d48e84bfd13e94"
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
