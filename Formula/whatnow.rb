# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.12.0/whatnow-darwin-arm64"
    sha256 "80f3f7ef01269400d2439811eeea9378d241fd9db5d497075d14cfc59ef1d987"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.12.0/whatnow-darwin-amd64"
    sha256 "994d9ce3bd786eb6ed0d49a5bcf9412b996441aefc8ae2f4cf8692d745d95906"
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
