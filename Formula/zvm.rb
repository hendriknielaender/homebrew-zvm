class Zvm < Formula
  desc "Zig Version Manager - Fast and simple Zig version management"
  homepage "https://github.com/hendriknielaender/zvm"
  version "0.16.0"
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
      sha256 "046ada906b953c4fadf5092d3e999a034170eb223421897058d80e423b0a3439"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "69320d6c5ab3b8431a97e25775bdeb1006e286befd44bb73cbfceb155831afc6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "074e28ed44f3ebc76be19d4cbbe1f78a7c4847f779f766cc6da53dfb48e5731c"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "1f9f1cf60617828a7644573af54fe7421cc63533e259da027cb14eccd56de5e6"
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
