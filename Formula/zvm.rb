class Zvm < Formula
  desc "Zig Version Manager"
  homepage "https://github.com/hendriknielaender/zvm"
  license "MIT"
  version "0.3.2"

  livecheck do
    url "https://github.com/hendriknielaender/zvm/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  if OS.mac? 
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "416a7170876aa0a6421deb11e053f1b4cd8f450aa9eb50e4856d47fc7bb66f5a"
      @@executable = "x86_64-macos-zvm"
    else Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "34b59ffd8d29d1ea0022d225ce87684ad188d3f8391551e8b15604fbacd2a7af"
      @@executable = "aarch64-macos-zvm"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "0d99aeeafd781e037a992efb4564e8fe80f3842ff31cdafa0438cd235a78bc2f"
      @@executable = "aarch64-linux-zvm"
    elsif Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "5b1343fea09ea4be5636a662690bb47d0bb676a9d61866388c033a917827f569"
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

