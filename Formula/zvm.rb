class Zvm < Formula
  desc "Zig Version Manager"
  homepage "https://github.com/hendriknielaender/zvm"
  license "MIT"
  version "0.11.0"

  livecheck do
    url "https://github.com/hendriknielaender/zvm/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  if OS.mac? 
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "0b6acee26035a285ceb2f2f29e7281a2a6704ebbf21958a79cdd776dfc6fa976"
      @@executable = "x86_64-macos-zvm"
    else Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "9a04b35f3678edf2054e89ed33a357afa16960b0dd5f1776a03df769972e4fe6"
      @@executable = "aarch64-macos-zvm"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "bec1c39a0c0f7cd8843c0805d65ad0b52d0ed830ecb573fc912f969721c97c8d"
      @@executable = "aarch64-linux-zvm"
    elsif Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "1b8565adc36d1647aadbc6333926722f768f2db0542bf1f99161794eb40da0d2"
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

