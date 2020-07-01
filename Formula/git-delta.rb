class GitDelta < Formula
  desc "Syntax-highlighting pager for git and diff output"
  homepage "https://github.com/dandavison/delta"
  url "https://github.com/dandavison/delta/archive/0.2.0.tar.gz"
  sha256 "c093d40e7a069572fc31407a39dcb6a77094acb5b52518691de6f8f0c21530de"
  head "https://github.com/dandavison/delta.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2c934142464323e5b0061b633f964acd0fe3b9f87787693c086e3109c24cf4dc" => :catalina
    sha256 "da93a1dd32a32cf39ef98baedabcc83f041bdb7b0d4721e5304b175dacea4b10" => :mojave
    sha256 "9c88edbe0c662fcd99c16789c0de39d25e5537edb74cff26f1929785fb7b70fd" => :high_sierra
  end

  depends_on "rust" => :build
  uses_from_macos "llvm"

  conflicts_with "delta", :because => "both install a `delta` binary"

  def install
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "delta #{version}", `#{bin}/delta --version`.chomp
  end
end
