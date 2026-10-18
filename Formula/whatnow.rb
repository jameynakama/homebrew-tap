# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.4.0/whatnow-darwin-arm64"
    sha256 "4ace4f7b31d754e09ae656bb69b9194f3ffd85182d3091c3fff2d8b180ccacc4"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.4.0/whatnow-darwin-amd64"
    sha256 "f0e82927abd9a4e4725da03ae7e5beb0792e9031395ab0a9306035be3519680e"
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
