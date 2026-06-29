class Zvm < Formula
  desc "Zig Version Manager - Fast and simple Zig version management"
  homepage "https://github.com/hendriknielaender/zvm"
  version "1.2.0"
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
      sha256 "bde77e3471209f603ac438bb2bec45b4d1e788b6a8ff55dc4e2fe6ebe7dd7985"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "275a92ca584627e36f78cc1fbf14c421fa133b1eda64927cc0a28692666b5de7"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "20f57a2134ffc6cced08a03bfa3f15b0c3a4e5836ab33f1ee0d131b44089ace7"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "0a65cf2721e144150e8b699c6d1b8d7206f131fd8b100d7d01889de6aa18a0cb"
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
