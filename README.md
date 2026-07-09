# branchify

Convert an arbitrary string into a valid git branch name.

```
branchify "Fix bug: user login fails!!"
# -> fix-bug-user-login-fails

echo "Add OAuth2 support (v2)" | branchify
# -> add-oauth2-support-v2
```

## Install

Prebuilt packages (`.deb`, the Windows scripts zip, `PKGBUILD`) are attached
to every [GitHub release](https://github.com/murshid1988/branchify/releases).

### macOS / Linux (via Homebrew)

Requires [Homebrew](https://brew.sh) to already be installed.

```
brew tap murshid1988/branchify
brew trust --formula murshid1988/branchify/branchify
brew install branchify
```

(The `brew trust` step is required by Homebrew's tap trust feature for
formulae from non-official taps.)

Uninstall: `brew uninstall branchify`

### Debian / Ubuntu (apt / dpkg)

Download the `.deb` from the [latest release](https://github.com/murshid1988/branchify/releases/latest)
and install it:

```
curl -LO https://github.com/murshid1988/branchify/releases/latest/download/branchify_1.1.0_all.deb
sudo apt install ./branchify_1.1.0_all.deb
```

Uninstall: `sudo apt remove branchify`

### Arch Linux (pacman)

Download `PKGBUILD` from the [latest release](https://github.com/murshid1988/branchify/releases/latest)
and build it locally:

```
curl -LO https://github.com/murshid1988/branchify/releases/latest/download/PKGBUILD
makepkg -si
```

Uninstall: `sudo pacman -R branchify`

### macOS / Linux (manual, no package manager)

Download the script and put it on your `PATH`:

```
sudo curl -o /usr/local/bin/branchify \
  https://raw.githubusercontent.com/murshid1988/branchify/main/to-branch-name.sh
sudo chmod +x /usr/local/bin/branchify
```

Uninstall: run [`uninstall.sh`](uninstall.sh) from this repo, or manually
`sudo rm /usr/local/bin/branchify`.

### Windows

**Native PowerShell** (no WSL/bash required):

```powershell
irm https://raw.githubusercontent.com/murshid1988/branchify/main/windows/install.ps1 | iex
```

This installs to `%LOCALAPPDATA%\branchify` and adds it to your user `PATH`.
Restart your terminal, then run `branchify "Some Title"`.

Uninstall:

```powershell
irm https://raw.githubusercontent.com/murshid1988/branchify/main/windows/uninstall.ps1 | iex
```

**WSL / Git Bash** (using the bash script instead):

- **WSL**: install [WSL](https://learn.microsoft.com/windows/wsl/install), then follow the
  Linux instructions above inside your WSL distro (Homebrew, apt, or manual).
- **Git Bash**:
  ```
  curl -o branchify.sh https://raw.githubusercontent.com/murshid1988/branchify/main/to-branch-name.sh
  bash branchify.sh "Some Title"
  ```

## Usage

```
branchify [STRING ...]
echo STRING | branchify
```

See `man branchify` for the full list of rules enforced (based on
`git check-ref-format --branch`).

## License

MIT
