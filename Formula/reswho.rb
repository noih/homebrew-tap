class Reswho < Formula
  desc "Read-only resource attribution for macOS"
  homepage "https://github.com/noih/reswho"
  url "https://github.com/noih/reswho/releases/download/v1.0.0/reswho-v1.0.0-aarch64-apple-darwin.tar.gz"
  sha256 "38bf91be5ac3cf7225ac08470fef7ad87b335cf7d536352aa34d01172ee9b50c"
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
