function Apache-Logs.ps1($page, $http_code, $browser){
$first= Get-Content -Path C;|xampp\apache\logs\access.log | Select-String $page
$second= $first | Select-String $http_code
$third= $second | Select-String $browser

$third
}

Apache-Logs.ps1 "index.html" 200 "Chrome"