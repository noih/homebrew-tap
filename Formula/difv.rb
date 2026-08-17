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
  url "https://github.com/noih/difv/releases/download/v1.0.2/difv-v1.0.2-aarch64-apple-darwin.tar.gz"
  sha256 "e2302eb9d2f3bef3453f3fbabaac1765e9038a62ade41edee574a8847515b383"
  license "MIT"

  # difv shells out to git rather than linking a git library.
  depends_on "git"

  # Apple Silicon only. `cargo install` still builds on an Intel Mac.
  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/noih/difv/releases/download/v1.0.2/difv-v1.0.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "97934226c3416005cd0a48e18f0ec6a4ebce97927b96fb641961898ed1df7c06"
    end
    on_intel do
      url "https://github.com/noih/difv/releases/download/v1.0.2/difv-v1.0.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ac55c76121e2fe138c677f2e0a4fb4d60f93796a12c068453c235a9b5d0da39"
    end
  end

  def install
    bin.install "difv"
  end

  test do
    assert_match "difv #{version}", shell_output("#{bin}/difv --version")
  end
end
