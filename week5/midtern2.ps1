function Get-ApacheLogs {
param (
[string]$LogPath = "C:\Users\champuser\Downloads\access.log",
[array]$IOCs
)

$results = @()
$logs = @()

foreach ($line in Get-Content $LogPath) {
$parts = $line -split ' ' 
if ($parts.Count -ge 9) {
$logEntry = [PSCustomObject]@{
IP = $parts[0]
Time = $parts[3] + " " + $parts[4]
Method = $parts[5].Trim('"')
Page = $parts[6]
Protocol = $parts[7].Trim('"')
Response = $parts[8]
Referrer = if ($parts.Count -ge 11) { $parts[10].Trim('"') } else {"-"}
}
$logs += $logEntry
}
}
foreach ($log in $logs) {
foreach ($ioc in $IOCs) {
if ($log.Page -match $ioc.Pattern) {
$results += $log
break
}
}
}
return $results
}



