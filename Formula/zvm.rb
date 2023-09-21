class Zvm < Formula
  desc "Zig Version Manager"
  homepage "https://github.com/hendriknielaender/zvm"
  url "https://github.com/hendriknielaender/zvm/releases/download/v0.1.0-beta/zvm-darwin-x64.zip"
  version "0.1.0"
  sha256 "0ca19acdfe4837329c7fa7ae18914fa5f49b6c2a1203ae6f4505baa2cc8e93d8"

  def install
    bin.install "zvm"
  end

  test do
    assert_match to_s(version), shell_output("#{bin}/zvm --version")
  end
end
