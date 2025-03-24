
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot functions_logs.ps1)
. (Join-Path $PSScriptRoot main1.ps1)
. (Join-Path $PSScriptRoot chrome-start-stop.ps1)
. (Join-Path $PSScriptRoot win_apache_functions.ps1)
clear



$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 Apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Open/Close Chrome App`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }
    if($choice -eq 1){
        cd C:\Users\champuser\SYS320-01\week4
        $item = .\win_apache_logs.ps1
        $item | Select-Object -Last 10
        Write-Host $item | Out-String
        }
    if($choice -eq 2){
        cd C:\Users\champuser\SYS320-01\week3
        $item = numberofdays(90)
        $item | select-object -last 10
        Write-Host $item | Out-String
    }
    if($choice -eq 3){
        atRiskUsers 90


    }
    if($choice -eq 4){
        Chrome-Start
        }
}
Write-Host "Sourcing: $(Join-Path $PSScriptRoot 'Users.ps1')"