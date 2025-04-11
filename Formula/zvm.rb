class Zvm < Formula
  desc "Zig Version Manager"
  homepage "https://github.com/hendriknielaender/zvm"
  license "MIT"
  version "0.10.0"

  livecheck do
    url "https://github.com/hendriknielaender/zvm/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  if OS.mac? 
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "8a9c47fa3ed1e959d46540d8aef4f3564207b1a2e3ecf6cadd5e9a5d1dd637b7"
      @@executable = "x86_64-macos-zvm"
    else Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "0f88d5b0782d0674ad7aeb8632ff393544f916af7465833d9494993b63804e6d"
      @@executable = "aarch64-macos-zvm"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "93efdaa7816b42eb4340d300ad726505bb7ebdfc114a91cdcb61c1d4d0709eba"
      @@executable = "aarch64-linux-zvm"
    elsif Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "35675b8b2d6d7d209b4b02b102a8a7bc69451a3e08e6a4eac8d06628deca104e"
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

