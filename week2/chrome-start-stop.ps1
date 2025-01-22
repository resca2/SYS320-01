#is chrome running? if so, end it, if not, start it


if (Get-Process -Name "chrome" -ErrorAction SilentlyContinue) {
    Stop-Process -Name chrome
} else { Start-Process "chrome.exe"
}