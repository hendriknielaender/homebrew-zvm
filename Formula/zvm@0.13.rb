class ZvmAT013 < Formula
  desc "Zig Version Manager (Legacy version 0.13.x)"
  homepage "https://github.com/hendriknielaender/zvm"
  license "MIT"
  version "0.13.0"
  
  # This is a versioned formula for legacy support
  keg_only :versioned_formula

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "previous-intel-mac-sha256-here"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "previous-arm-mac-sha256-here"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "previous-intel-linux-sha256-here"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "previous-arm-linux-sha256-here"
    end
  end

  def install
    executable_name = if OS.mac?
      Hardware::CPU.intel? ? "x86_64-macos-zvm" : "aarch64-macos-zvm"
    elsif OS.linux?
      Hardware::CPU.intel? ? "x86_64-linux-zvm" : "aarch64-linux-zvm"
    else
      odie "Unsupported platform"
    end

    bin.install executable_name => "zvm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zvm --version")
    system "#{bin}/zvm", "list"
  end
end