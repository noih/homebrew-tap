class Reswho < Formula
  desc "Read-only resource attribution for macOS"
  homepage "https://github.com/noih/reswho"
  url "https://github.com/noih/reswho/releases/download/v1.1.1/reswho-v1.1.1-aarch64-apple-darwin.tar.gz"
  sha256 "f1588f27be7f586b6b97821ca2322ad6507a3afab7b3969e3bd0ac7ceb6dd941"
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
