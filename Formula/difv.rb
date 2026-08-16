# Filled in by .github/workflows/release.yml and attached to each release as
# difv.rb. Copy it into the tap repository (noih/homebrew-tap) as
# Formula/difv.rb — see the Install section of the README.
class Difv < Formula
  desc "Review and tweak your Git changes side by side, in the terminal"
  homepage "https://github.com/noih/difv"
  version "1.0.0"
  license "MIT"

  # Apple Silicon only. An Intel Mac gets a clear refusal from Homebrew rather
  # than a formula with nothing to download; `cargo install` still works there.
  on_macos do
    depends_on arch: :arm64
    url "https://github.com/noih/difv/releases/download/v1.0.0/difv-v1.0.0-aarch64-apple-darwin.tar.gz"
    sha256 "a928aaaf382d579d0589e829b444b48463cace262f2c11ff4e502003ae46a422"
  end

  on_linux do
    on_arm do
      url "https://github.com/noih/difv/releases/download/v1.0.0/difv-v1.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3d02247703107edf00ce90faea0982409e5a30cadf627ca0017008762dbdf37f"
    end
    on_intel do
      url "https://github.com/noih/difv/releases/download/v1.0.0/difv-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "139ed60b8081405044ce9018cc9e2c886fd9eafaf7d0a92e098436d08583da2a"
    end
  end

  # difv shells out to git rather than linking a git library.
  depends_on "git"

  def install
    bin.install "difv"
  end

  test do
    assert_match "difv #{version}", shell_output("#{bin}/difv --version")
  end
end
