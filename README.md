# branchify

Convert an arbitrary string into a valid git branch name.

```
branchify "Fix bug: user login fails!!"
# -> fix-bug-user-login-fails

echo "Add OAuth2 support (v2)" | branchify
# -> add-oauth2-support-v2
```

## Install

### macOS / Linux (via Homebrew)

Requires [Homebrew](https://brew.sh) to already be installed.

```
brew tap murshid1988/branchify
brew trust --formula murshid1988/branchify/branchify
brew install branchify
```

(The `brew trust` step is required by Homebrew's tap trust feature for
formulae from non-official taps.)

### macOS / Linux (manual, no Homebrew)

Download the script and put it on your `PATH`:

```
curl -o /usr/local/bin/branchify \
  https://raw.githubusercontent.com/murshid1988/branchify/main/to-branch-name.sh
chmod +x /usr/local/bin/branchify
```

### Windows

`branchify` is a bash script, so it needs a bash environment:

- **WSL**: install [WSL](https://learn.microsoft.com/windows/wsl/install), then follow the
  Linux instructions above inside your WSL distro (Homebrew or manual).
- **Git Bash**: download the script and run it directly with bash:
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
