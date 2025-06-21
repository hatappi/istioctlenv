# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

istioctlenv is an istioctl version management tool modeled after rbenv and goenv. It allows users to:
- Manage multiple istioctl versions on a single system
- Set global and per-project istioctl versions
- Use shims to intercept istioctl commands and route them to the correct version

## Architecture

The tool follows the standard *env pattern:
- **Shims**: Lightweight executables in `~/.istioctlenv/shims/` that intercept istioctl commands
- **Version Resolution**: Checks `ISTIOCTLENV_VERSION` env var → `.istioctl-version` file in current/parent dirs → global `~/.istioctlenv/version` file → system istioctl
- **Installation Directory**: Each istioctl version is installed in `~/.istioctlenv/versions/<version>/`
- **Plugin System**: Uses `istioctl-build` plugin for downloading and installing istioctl binaries

## Key Components

- **libexec/**: Contains all istioctlenv commands as individual bash scripts
- **plugins/istioctl-build/**: Plugin that handles downloading istioctl binaries from Istio releases
- **completions/**: Shell completion scripts for bash, zsh, and fish
- **scripts/gen_new_build.sh**: Utility to generate build definitions for new istioctl versions

## Common Commands

### Development
- `./scripts/gen_new_build.sh <version>` - Generate build definition for a new istioctl version
- Check plugins/istioctl-build/share/istioctl-build/ for available versions

### Testing
- No automated test suite present
- Manual testing involves installing versions and verifying shim behavior

### Installation Management
- `istioctlenv install <version>` - Install a specific istioctl version
- `istioctlenv global <version>` - Set global istioctl version
- `istioctlenv local <version>` - Set local istioctl version for current directory
- `istioctlenv versions` - List all installed versions
- `istioctlenv rehash` - Regenerate shims after installation

## Build Definitions

New istioctl versions are added by:
1. Running `./scripts/gen_new_build.sh <version>` to generate build file
2. The script fetches release assets from GitHub API and creates installation definitions
3. Build files are stored in `plugins/istioctl-build/share/istioctl-build/<version>`

## Shell Integration

The tool requires shell integration via `eval "$(istioctlenv init -)"` to:
- Add shims directory to PATH
- Enable shell completion
- Set up environment for version switching

## Release Process

- When we add a new version, execute `./scripts/gen_new_build.sh`.
  e.g. `./scripts/gen_new_build.sh 1.26.1`

## GitHub Pull Requests

- When you open a GitHub PR, please must to use template in .github/PULL_REQUEST_TEMPLATE.md