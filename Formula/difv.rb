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
  url "https://github.com/noih/difv/releases/download/v1.0.6/difv-v1.0.6-aarch64-apple-darwin.tar.gz"
  sha256 "82c1a074f8c14de93a406fb6efe5e07acbd5fc89865b5965f7b98195017aa5de"
  license "MIT"

  # difv shells out to git rather than linking a git library.
  depends_on "git"

  # Apple Silicon only. `cargo install` still builds on an Intel Mac.
  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/noih/difv/releases/download/v1.0.6/difv-v1.0.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5de2f3ed205a92a7d41cf636a15b0109a79e9afbc5c5892c89caf6ad18fd7893"
    end
    on_intel do
      url "https://github.com/noih/difv/releases/download/v1.0.6/difv-v1.0.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5c0d540617e743115908789c707fe6219b8586bae78c1ff6215f50c2c1678640"
    end
  end

  def install
    bin.install "difv"
  end

  test do
    assert_match "difv #{version}", shell_output("#{bin}/difv --version")
  end
end
