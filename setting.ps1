# Powerline
if (!(Get-InstalledModule oh-my-posh)) {
    Install-Module oh-my-posh -Scope CurrentUser -Force
}
if (($PSVersionTable.PSVersion.Major) -gt 5 -and !(Get-InstalledModule PSReadLine)) {
    Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
}

# fzf
if (!(Get-InstalledModule PSFzf)) {
    Install-Module -Name PSFzf -Scope CurrentUser -Force
}

# scoop
try {
    get-command scoop -ErrorAction Stop
} 
catch [Exception] {
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    $env:Path = $env:USERPROFILE + "\scoop\shims;" + $env:Path
}

scoop install aria2 
scoop install git sudo python fzf ghq ffmpeg-nightly youtube-dl gow

scoop bucket add versions

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
}

# pipenv
try {
    get-command pipenv -ErrorAction Stop
} 
catch [Exception] {
    pip install pipenv
}
