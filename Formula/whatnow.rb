# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.11.0/whatnow-darwin-arm64"
    sha256 "403c0d792eedea7d6fde1abc5cd08e2f90227d43544d76bf94bc36daf7fc8757"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.11.0/whatnow-darwin-amd64"
    sha256 "18e4c94b700f7e1bc68cacc80591e3443ad81619b48f36c1c44f70138571aee8"
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
