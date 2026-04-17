class Zvm < Formula
  desc "Zig Version Manager - Fast and simple Zig version management"
  homepage "https://github.com/hendriknielaender/zvm"
  version "0.18.0"
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
      sha256 "368fb3564355ccceb9a8c9b9804ad684a7cd3c3ae7c96d4e629aa6735935fd89"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "76ad0e7b4616d9036dfe9bae7f7485c499031c7eaf5bbf4736210070a5fb92f9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "a42b966ea8cce03d53bb033fcfad3b684828742dd2bc991bdba9d316a52203ed"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "705448c7eb3520a732aad3e085c3a8513334041bda0dc8c4c56b9846f6df71fb"
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
