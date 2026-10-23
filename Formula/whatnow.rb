# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.6.0/whatnow-darwin-arm64"
    sha256 "ae60decbb67c0a8632a489ba1f0a38cd92fb4be6a0c4040c6a8939d5b0ddb547"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.6.0/whatnow-darwin-amd64"
    sha256 "0985182931c1f6f5c0b371735a3ee4db849da5fbda9b3cd04f44abfe0403d387"
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
