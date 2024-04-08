class Zvm < Formula
  desc "Zig Version Manager"
  homepage "https://github.com/hendriknielaender/zvm"
  license "MIT"
  version "0.3.0"

  livecheck do
    url "https://github.com/hendriknielaender/zvm/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "e386032f79a1808d1c656dd028c97818e404124e8933f6d9387d7a4e47efefb9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "fa6f92b91e737ba54286594931364f617acba8f5627bb7bf5f6b3271563f8237"
    elsif Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "05d75b136cbbd7512889ac97b58ef375b6d457dc3c459b884d2d3301ff9bb1aa"
    end
  else
    odie "Unsupported platform. Please submit a bug report here: https://github.com/hendriknielaender/zvm/issues\n#{OS.report}"
  end

  def install
    bin.install "zvm" => "zvm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zvm --version")
  end
end

