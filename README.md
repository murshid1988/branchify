# branchify

Convert an arbitrary string into a valid git branch name.

```
branchify "Fix bug: user login fails!!"
# -> fix-bug-user-login-fails

echo "Add OAuth2 support (v2)" | branchify
# -> add-oauth2-support-v2
```

## Install

```
brew tap murshid1988/branchify
brew trust --formula murshid1988/branchify/branchify
brew install branchify
```

(The `brew trust` step is required by Homebrew's tap trust feature for
formulae from non-official taps.)

## Usage

```
branchify [STRING ...]
echo STRING | branchify
```

See `man branchify` for the full list of rules enforced (based on
`git check-ref-format --branch`).

## License

MIT
