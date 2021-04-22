
# install

```:
Set-ExecutionPolicy -Scope Process Unrestricted
iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/re3turn/dotfiles_win/main/setting.ps1')
```

If `This script contains malicious content and has been blocked by your antivirus software` error message is output...

```:
$webreq = [System.Net.WebRequest]::Create('https://raw.githubusercontent.com/re3turn/dotfiles_win/main/setting.ps1')
$resp=$webreq.GetResponse()
$respstream=$resp.GetResponseStream()
$reader=[System.IO.StreamReader]::new($respstream)
$content=$reader.ReadToEnd()
iex($content)
```
