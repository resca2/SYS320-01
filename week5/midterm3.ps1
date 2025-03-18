function MatchingLogs {
param (
[array]$Logs,
[array]$IOCs
)
$matching = @()

foreach ($log in $Logs) {
foreach ($ioc in $IOCs) {
if ($log.Page -match $ioc.Pattern) {
$matching += $log
break
}
}
}
return $matching
}