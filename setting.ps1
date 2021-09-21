# Powerline
if (!(Get-InstalledModule oh-my-posh 2>Out-Null)) {
    Install-Module oh-my-posh -Scope CurrentUser -Force
}
if (($PSVersionTable.PSVersion.Major) -ge 5 -and !(Get-InstalledModule PSReadLine 2>Out-Null)) {
    Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
}

# fzf
if (!(Get-InstalledModule PSFzf 2>Out-Null)) {
    Install-Module -Name PSFzf -Scope CurrentUser -Force
}

# scoop
try {
    get-command scoop -ErrorAction Stop
}
catch [Exception] {
    Set-ExecutionPolicy RemoteSigned -Scope Process
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    $env:Path = $env:USERPROFILE + "\scoop\shims;" + $env:Path
}

scoop install aria2
scoop config aria2-enabled true

scoop install git

# bucket
scoop bucket add versions
scoop bucket add my-app-bucket https://github.com/re3turn/scoop-bucket

scoop install sudo python go fzf ghq ffmpeg-nightly gow innounp bat jq jid 7zip tar win32yank

# youtube-dl
try {
    get-command youtube-dl -ErrorAction Stop
}
catch [Exception] {
    scoop install youtube-dl

    $tempDir = New-TemporaryFile | %{ rm $_; mkdir $_ }
    $exePath = "$tempDir\vcredist.exe"
    curl.exe -o $exePath 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe'
    iex "$exePath Setup /q"
    $tempDir | Remove-Item -Recurse
}


# pip
try {
    get-command pip -ErrorAction Stop
}
catch [Exception] {
    [System.Environment]::SetEnvironmentVariable('path', $(scoop prefix python) + "\Scripts;" + [System.Environment]::GetEnvironmentVariable("Path", "User"), "User")
    $env:Path = $(scoop prefix python) + "\Scripts;" + $env:Path
    python -m pip install --upgrade pip
}
# pyenv
try {
    get-command pyenv -ErrorAction Stop
}
catch [Exception] {
    pip install pyenv-win --target $HOME\.pyenv
    [System.Environment]::SetEnvironmentVariable('PYENV', $env:USERPROFILE + "\.pyenv\pyenv-win\", "User")
    [System.Environment]::SetEnvironmentVariable('PYENV_HOME', $env:USERPROFILE + "\.pyenv\pyenv-win\", "User")
    [System.Environment]::SetEnvironmentVariable('path', $HOME + "\.pyenv\pyenv-win\bin;" + $HOME + "\.pyenv\pyenv-win\shims;" + [System.Environment]::GetEnvironmentVariable("Path", "User"), "User")
    [System.Environment]::SetEnvironmentVariable('PIPENV_VENV_IN_PROJECT', "1", "User")
}

# pipenv
try {
    get-command pipenv -ErrorAction Stop
}
catch [Exception] {
    pip install pipenv
}
