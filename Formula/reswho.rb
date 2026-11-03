class Reswho < Formula
  desc "Read-only resource attribution for macOS"
  homepage "https://github.com/noih/reswho"
  url "https://github.com/noih/reswho/releases/download/v1.0.1/reswho-v1.0.1-aarch64-apple-darwin.tar.gz"
  sha256 "2ac1d1a5448fd307e85e1ced6f96a75adf8d403e2c0c22e73871a316e7afb373"
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
