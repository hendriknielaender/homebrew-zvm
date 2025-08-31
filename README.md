# homebrew-zvm

Official Homebrew tap for [zvm (Zig Version Manager)](https://github.com/hendriknielaender/zvm)

## Installation

```bash
# Add the tap
brew tap hendriknielaender/zvm

# Install the latest version
brew install zvm

# Install a specific version (if available)
brew install zvm@0.13
```

## Usage

```bash
# Check installed version
zvm --version

# List available Zig versions
zvm list-remote

# Install a Zig version
zvm install 0.13.0

# Use a specific Zig version
zvm use 0.13.0
```

## Supported Versions

- **zvm** - Latest stable release (automatically updated)

*Note: Versioned formulas (like `zvm@0.14`) can be created when needed for legacy support using the "Create Versioned Formula" GitHub Action.*

### Version Management Strategy

**Automatic Updates:**
- The main `zvm` formula automatically updates to the latest release
- Triggered by new GitHub releases in the zvm repository
- Updates version number and SHA256 checksums automatically

**Versioned Formulas:**
- Created manually when major changes require legacy support  
- Use the "Create Versioned Formula" GitHub Action for easy creation
- Follow the pattern: `zvm@<major.minor>` (e.g., `zvm@0.14`, `zvm@1.0`)
- Maximum of 5 supported versions at any time

## Features

✅ **Multi-platform support** - macOS (Intel/ARM) and Linux (Intel/ARM)  
✅ **Automated updates** - Formula updates automatically when new releases are published  
✅ **Comprehensive testing** - All platforms tested in CI  
✅ **Security focused** - SHA256 verification for all downloads  
✅ **Shell completions** - Bash, Zsh, and Fish support (if available)

## Development

### Testing Changes

```bash
# Test formula syntax
brew audit --strict Formula/zvm.rb
brew style Formula/zvm.rb

# Test installation
brew test Formula/zvm.rb
brew install --build-from-source Formula/zvm.rb
```

### Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/improvement`)
3. Test your changes locally
4. Submit a pull request

All formula changes are automatically tested across:
- Ubuntu Linux (x86_64)
- macOS Intel (x86_64) 
- macOS Apple Silicon (ARM64)

## Automation

### Main Formula Updates (Automatic)
- **Triggered by**: New releases in the main zvm repository  
- **Process**: Downloads release assets, computes checksums, updates `Formula/zvm.rb`
- **Review**: Creates pull requests for manual review before merge
- **Testing**: Runs comprehensive tests across all supported platforms

### Versioned Formulas (Manual)
- **When needed**: Major breaking changes or legacy support requirements
- **Process**: Use GitHub Actions → "Create Versioned Formula" workflow
- **Maintenance**: Requires manual updates for security patches
- **Deprecation**: Old versions removed when no longer maintained

### Example: Releasing zvm 0.15.0

1. **Automatic**: Main formula updates to 0.15.0
2. **Manual** (if needed): Create `zvm@0.14` before the update
3. **Result**: 
   - `brew install zvm` → installs 0.15.0
   - `brew install zvm@0.14` → installs 0.14.x (if created)

## Security

- All downloads verified with SHA256 checksums
- Only official GitHub release assets are used
- Automated security scanning in CI
- See [SECURITY.md](SECURITY.md) for more details

## Support

- 🐛 **Bug reports**: [GitHub Issues](https://github.com/hendriknielaender/homebrew-zvm/issues)
- 💬 **Questions**: [GitHub Discussions](https://github.com/hendriknielaender/zvm/discussions)
- 📖 **Documentation**: [zvm repository](https://github.com/hendriknielaender/zvm)