class Zvm < Formula
  desc "Zig Version Manager"
  homepage "https://github.com/hendriknielaender/zvm"
  license "MIT"
  version "0.7.0"

  livecheck do
    url "https://github.com/hendriknielaender/zvm/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  if OS.mac? 
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "fd8f0f3e68e491c05cd0f3f829ca6127c3df507a3062d8dee692a38b3cf6b5a3"
      @@executable = "x86_64-macos-zvm"
    else Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "2c937c88cf306fbdf94b50c6d866d6745d69be3296c9800bdc36270b60badaeb"
      @@executable = "aarch64-macos-zvm"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "b77f6f9ab2d65d1ca7236c4d5f82deca3186efd32be85908461bf8c3f28708e8"
      @@executable = "aarch64-linux-zvm"
    elsif Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "461ac5d321bd43705c7b17988d5d2b7d2e3a1f3ee37564ec4ea2d19512acb683"
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

