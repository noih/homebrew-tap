# Filled in by .github/workflows/release.yml and attached to each release as
# difv.rb. Copy it into the tap repository (noih/homebrew-tap) as
# Formula/difv.rb — see the Install section of the README.
#
# Shaped to pass both of the tap's checks. `brew readall --os=all --arch=all`
# loads the formula on every platform, so every platform must see a URL: the
# macOS build is the top-level default and Linux overrides it. `brew audit
# --strict` wants no `version` (read from the URL) and `depends_on` before the
# platform blocks.
class Difv < Formula
  desc "Review and tweak your Git changes side by side, in the terminal"
  homepage "https://github.com/noih/difv"
  # The macOS build is the default; Linux overrides it below. An Intel Mac never
  # fetches it — `depends_on arch: :arm64` refuses first — but every platform
  # has to declare some URL for the formula to load at all.
  url "https://github.com/noih/difv/releases/download/v1.0.4/difv-v1.0.4-aarch64-apple-darwin.tar.gz"
  sha256 "c38f6bb92c58d29cd14a88378d6d87a9bc482947f2670e1ab8885d24fd2e87f9"
  license "MIT"

  # difv shells out to git rather than linking a git library.
  depends_on "git"

  # Apple Silicon only. `cargo install` still builds on an Intel Mac.
  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/noih/difv/releases/download/v1.0.4/difv-v1.0.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bcb616e61206ae2f63e8fdf9a83bca2073f3a3ab95addba55adfe866a56b7d80"
    end
    on_intel do
      url "https://github.com/noih/difv/releases/download/v1.0.4/difv-v1.0.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "09d911c9fccde6c94e3236cb5d760694802ff4136ad843ebd956a7eddb906ccc"
    end
  end

  def install
    bin.install "difv"
  end

  test do
    assert_match "difv #{version}", shell_output("#{bin}/difv --version")
  end
end
