class Reswho < Formula
  desc "Read-only resource attribution for macOS"
  homepage "https://github.com/noih/reswho"
  url "https://github.com/noih/reswho/releases/download/v1.1.2/reswho-v1.1.2-aarch64-apple-darwin.tar.gz"
  sha256 "3a9da3067bc2027b177fe1e3e34834a1bd41c87e4a9ab41b3b98ee33ccb05c54"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    bin.install "reswho"
  end

  test do
    (testpath/"config.json").write '{"version":1,"settings":{}}'
    assert_match "reswho #{version}", shell_output("#{bin}/reswho --version")
    assert_match "sampling", shell_output("#{bin}/reswho --config #{testpath}/config.json settings --json")
  end
end
