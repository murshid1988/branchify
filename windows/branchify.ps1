<#
.SYNOPSIS
Convert an arbitrary string into a valid git branch name.

.EXAMPLE
./branchify.ps1 "Fix bug: user login fails!!"
# -> fix-bug-user-login-fails

.EXAMPLE
"Add OAuth2 support (v2)" | ./branchify.ps1
# -> add-oauth2-support-v2
#>

function ConvertTo-BranchName {
    param([string]$Text)

    $s = $Text.ToLowerInvariant()

    # whitespace/underscores -> hyphens
    $s = [regex]::Replace($s, '[\s_]+', '-')

    # remove characters git disallows in refs: ~ ^ : ? * [ \ and control chars
    $s = [regex]::Replace($s, '[~^:?*\[\\]', '')
    $s = [regex]::Replace($s, '[\x00-\x1F\x7F]', '')

    # drop "@{" sequences
    $s = $s -replace '@\{', '-'

    # anything not alnum, dot, hyphen, slash -> hyphen
    $s = [regex]::Replace($s, '[^a-z0-9./\-]+', '-')

    # collapse consecutive dots ".." -> "."
    $s = [regex]::Replace($s, '\.{2,}', '.')

    # collapse consecutive slashes and hyphens
    $s = [regex]::Replace($s, '/{2,}', '/')
    $s = [regex]::Replace($s, '-{2,}', '-')

    # strip leading/trailing dots, slashes, hyphens (repeat until stable)
    do {
        $prev = $s
        $s = [regex]::Replace($s, '^[./\-]+', '')
        $s = [regex]::Replace($s, '[./\-]+$', '')
    } while ($prev -ne $s)

    # strip ".lock" suffix if present
    $s = $s -replace '\.lock$', ''

    # guard against empty or reserved "@"
    if ([string]::IsNullOrEmpty($s) -or $s -eq '@') {
        $s = 'branch'
    }

    # truncate to 100 chars, then re-strip trailing separators from the cut
    if ($s.Length -gt 100) { $s = $s.Substring(0, 100) }
    $s = [regex]::Replace($s, '[./\-]+$', '')

    return $s
}

if ($args.Count -gt 0) {
    ConvertTo-BranchName -Text ($args -join ' ')
} else {
    $stdin = [Console]::In.ReadToEnd()
    ConvertTo-BranchName -Text $stdin.Trim()
}
