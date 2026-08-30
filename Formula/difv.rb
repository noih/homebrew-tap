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
  url "https://github.com/noih/difv/releases/download/v1.0.5/difv-v1.0.5-aarch64-apple-darwin.tar.gz"
  sha256 "89620bb8fbb82c288271d4d12130214f2ba8d98f204ab24a670b6f8cdc3088ac"
  license "MIT"

  # difv shells out to git rather than linking a git library.
  depends_on "git"

  # Apple Silicon only. `cargo install` still builds on an Intel Mac.
  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/noih/difv/releases/download/v1.0.5/difv-v1.0.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ea1e577e92a1e185d5b1d1d16db3ed5c4838679c5abc68021f5ae271e5d4125"
    end
    on_intel do
      url "https://github.com/noih/difv/releases/download/v1.0.5/difv-v1.0.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "136ddac1c4ccad37c4a84f02497cd196a944b7b0fb6c4e8b7cfac0cdda78e2fe"
    end
  end

  def install
    bin.install "difv"
  end

  test do
    assert_match "difv #{version}", shell_output("#{bin}/difv --version")
  end
end
