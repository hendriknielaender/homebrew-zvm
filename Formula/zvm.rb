class Zvm < Formula
  desc "Zig Version Manager - Fast and simple Zig version management"
  homepage "https://github.com/hendriknielaender/zvm"
  version "0.16.2"
  license "MIT"

  # Automated version detection
  livecheck do
    url :stable
    strategy :github_latest
  end

  # OS and architecture specific binary downloads
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-macos-zvm.tar.gz"
      sha256 "a1832e403fe007867249379e9c6e3762466998d1bd805b7e446a17c9c0a69d3a"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "7f7c99265968fe4685d82e06a293b54651d6213ce781506cc119ef76117a0e0a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "51cfbf14db28a291dd463bbd61f1dee1938a1aefa9bce3d3e42b902de1a5cc79"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "4b302200c3de9c10554a1a8f78d0c83c0fbf9e3ef9c76df507bd17f9c821a6cf"
    end
  end

  def install
    # Determine executable name based on platform
    executable_name = if OS.mac?
      Hardware::CPU.intel? ? "x86_64-macos-zvm" : "aarch64-macos-zvm"
    elsif OS.linux?
      Hardware::CPU.intel? ? "x86_64-linux-zvm" : "aarch64-linux-zvm"
    else
      odie "Unsupported platform"
    end

    # Install the binary
    bin.install executable_name => "zvm"

    # Install shell completions if they exist
    if (buildpath/"completions").exist?
      bash_completion.install "completions/zvm.bash" => "zvm"
      zsh_completion.install "completions/_zvm"
      fish_completion.install "completions/zvm.fish"
    end
  end

  test do
    # Basic version check
    assert_match version.to_s, shell_output("#{bin}/zvm --version")

    # Test core functionality
    system "#{bin}/zvm", "list"

    # Test remote list functionality
    output = shell_output("#{bin}/zvm list-remote 2>&1")
    assert_match(/zig/i, output)

    # Create test directory and verify zvm can operate
    testdir = testpath/"zvm-test"
    testdir.mkpath
    cd testdir do
      # Test that zvm can show help without error
      system "#{bin}/zvm", "help"

      # Test that binary is properly linked
      assert_predicate bin/"zvm", :executable?
    end
  end
end
