# `just release` in jameynakama/whatnow generates the tap's Formula/whatnow.rb from
# packaging/whatnow.rb there. Edit that template, not the tap's copy.
class Whatnow < Formula
  desc "Executive function for the rest of us: plans your day and picks what's next"
  homepage "https://github.com/jameynakama/whatnow"
  if Hardware::CPU.arm?
    url "https://github.com/jameynakama/whatnow/releases/download/v0.2.0/whatnow-darwin-arm64"
    sha256 "db9ed29e868659ef622566b68d5b2f56c9b51bba9a284ce5281c4879462b27e6"
  else
    url "https://github.com/jameynakama/whatnow/releases/download/v0.2.0/whatnow-darwin-amd64"
    sha256 "fc28bd8620a66a6b73a7541358bda66f71256e65d4861a108aa2836386178065"
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
