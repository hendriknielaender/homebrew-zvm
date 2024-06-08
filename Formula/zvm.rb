class Zvm < Formula
  desc "Zig Version Manager"
  homepage "https://github.com/hendriknielaender/zvm"
  license "MIT"
  version "0.3.3"

  livecheck do
    url "https://github.com/hendriknielaender/zvm/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  if OS.mac? 
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "ca52157d1379fcbcf0fc4b1d1a3796a5ba6aeb6d9bfc9882360f2cd723a8d5a3"
      @@executable = "x86_64-macos-zvm"
    else Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "ca346fc46e5650f1c04475a1f0d14e64e1d096f98665bc587ec098c9c9bcbf86"
      @@executable = "aarch64-macos-zvm"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "8288cd2614a7cff529338b5f5641ce5fda2758e9b8fcde5a078f888710332db2"
      @@executable = "aarch64-linux-zvm"
    elsif Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "8309031bb204edf441012f812b09cd8d5a8313a35aee7e7dbb1de6c651b7c465"
      @@executable = "x86_64-linux-zvm"
    end
  else
    odie "Unsupported platform. Please submit a bug report here: https://github.com/hendriknielaender/zvm/issues"
  end

  def install
    bin.install @@executable => "zvm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zvm --version")
  end
end

