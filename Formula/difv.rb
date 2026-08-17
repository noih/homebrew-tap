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
  url "https://github.com/noih/difv/releases/download/v1.0.3/difv-v1.0.3-aarch64-apple-darwin.tar.gz"
  sha256 "e63a18b70548acab8462d7459422bc3a184d0ec96c981c7c9d12b82a950588ae"
  license "MIT"

  # difv shells out to git rather than linking a git library.
  depends_on "git"

  # Apple Silicon only. `cargo install` still builds on an Intel Mac.
  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/noih/difv/releases/download/v1.0.3/difv-v1.0.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "248001b03c28335b7318efa2ff8db26bf41193fb4055a20306131633ca62cd32"
    end
    on_intel do
      url "https://github.com/noih/difv/releases/download/v1.0.3/difv-v1.0.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "59f19b16738699167613ab63f1b81a6c9c39a32f07aaf8274e351b904896ec11"
    end
  end

  def install
    bin.install "difv"
  end

  test do
    assert_match "difv #{version}", shell_output("#{bin}/difv --version")
  end
end
