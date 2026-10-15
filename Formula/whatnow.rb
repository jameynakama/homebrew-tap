# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.3.0/whatnow-darwin-arm64"
    sha256 "ea975f83f2a9d2096b56502c5ca59d3bef16e9cda571e17e5a723fe6c8bc779f"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.3.0/whatnow-darwin-amd64"
    sha256 "222c7452b5fcba5a9813d257f19533a4cdc2810963ec2a03f40f3aac06b6252d"
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
