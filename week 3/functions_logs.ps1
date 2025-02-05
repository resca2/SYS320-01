#
#Get-EventLog -LogName System -source Microsoft-Windows-Winlogon

#
function numberofdays($days){

$days = Read-Host "Enter the number of days you want to obtain logs from"
$loginoutsTable = numberofdays $days

# get login and log off for last 14 days and save to a variable
$loginouts = Get-EventLog -LogName System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)
$loginoutsTable = @()
for( $i = 0; $i -lt $loginouts.count; $i++){

#event property value
$event = ""
if($loginouts[$i].EventID -eq '7001') {$event="Logon"}
if($loginouts[$i].EventID -eq '7002') {$event="Logoff"}

#user property value
$user = $loginouts[$i].ReplacementStrings[1]

# translate user id to usernmae
$test= New-Object System.Security.Principal.SecurityIdentifier $user
$username= $test.Translate([System.Security.Principal.NTAccount])

#add each line to empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
"Id" = $loginouts[$i].EventID
"Event" = $event;
"User" = $username;
}
$days = Read-Host "Enter the number of days you want to obtain logs from"
$loginoutsTable = numberofdays $days
}

$loginoutsTable
}


