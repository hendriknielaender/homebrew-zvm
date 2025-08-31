class Zvm < Formula
  desc "Zig Version Manager - Fast and simple Zig version management"
  homepage "https://github.com/hendriknielaender/zvm"
  version "0.15.0"
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
      sha256 "049bde2d973ee6b04db8293c60dd6a286178a49af21107e3792daf568f1887b4"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-macos-zvm.tar.gz"
      sha256 "8a588d54a10049736b1857840d853df35451fc44d89b0dcc860ed913c0107b8c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/x86_64-linux-zvm.tar.gz"
      sha256 "ac2d81dfbc488c51e1c248c681cd28e507d5565ba7dc0a974f9979e2020d6bc6"
    elsif Hardware::CPU.arm?
      url "https://github.com/hendriknielaender/zvm/releases/download/v#{version}/aarch64-linux-zvm.tar.gz"
      sha256 "aac6b1c97e82c8a37fd3e4040d5585420208acc18d40d29b300ba91abf3e42ce"
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
