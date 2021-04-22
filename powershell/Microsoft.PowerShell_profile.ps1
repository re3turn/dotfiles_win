# Powerline
Set-PoshPrompt -Theme Paradox

# PSReadLine
Set-PSReadLineOption -EditMode Emacs

# fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Remove beep
Set-PSReadlineOption -BellStyle None

# Complete
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

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
Remove-Item ("alias:ls") -Force
Remove-Item ("alias:cp") -Force
Remove-Item ("alias:mv") -Force
Remove-Item ("alias:wget") -Force
Remove-Item ("alias:curl") -Force
