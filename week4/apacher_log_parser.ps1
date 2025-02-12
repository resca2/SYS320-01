function ApacheLogs1(){
$logsNotformatted = Get-Content -Path C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i=0; $i -lt $logsNotformatted.count; $i++){

$words = $logsNotformatted[$i].Split(" ");
$tableRecords += [pscustomobject]@{"IP" = $words[0];
"Time" = $words[3].Trim('[');
"Method" = $words[5].Trim('"')
"Page" = $words[6];
"Protocol" = $words[7];
"response" = $words[8];
"Referrer" = $words[10];
}
}
return $tableRecords | Where-Object { $_.IP -like "10.*"}
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap
