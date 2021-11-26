# Powerline
Set-PoshPrompt -Theme Paradox

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
# Remove beep
Set-PSReadlineOption -BellStyle None
# Complete
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# function
# cd $env:USERPROFILE
# sudo ln -s "<WSL_NETWORK_GHQ_ROOT_PATH>" ghq
function gcd() {
    if (!(Get-Command ghq -ea SilentlyContinue)) {
        Write-Host "Error: ghq command is not install" -ForegroundColor DarkRed 2>&1
        return
    }
    if ($args.Length -ne 1) {
        if (!(Get-Command fzf -ea SilentlyContinue)) {
            Write-Host "Error: fzf command is not install" -ForegroundColor DarkRed 2>&1
            return
        }

        if ((ghq list | wc -l) -eq 0) {
            Write-Host "Error: ghq no repository" -ForegroundColor DarkRed 2>&1
            return
        }
        ghq list | fzf | Select-Object -First 1 | ForEach-Object { Set-Location "$(ghq root)/$_" }
        return
    }

    $GHQ = (ghq root) + "/github.com"
    $ME = (git config --get user.name)

    ghq get -p $args
    if ((dirname $args) -eq ".") {
        Set-Location $GHQ/$ME/$args
    }
    else {
        Set-Location $GHQ/$args
    }
}

# del alias
if (!!(Get-Alias cp > $null 2>&1)) {
    Remove-Item ("alias:cp") -Force
}
if (!!(Get-Alias mv > $null 2>&1)) {
    Remove-Item ("alias:mv") -Force
}
if (!!(Get-Alias wget > $null 2>&1)) {
    Remove-Item ("alias:wget") -Force
}
if (!!(Get-Alias curl > $null 2>&1)) {
    Remove-Item ("alias:curl") -Force
}
