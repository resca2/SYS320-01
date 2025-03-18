.(Join-Path $PSScriptRoot scraping.ps1)
$FullTable = gatherClasses
$FullTable = daysTranslator $FullTable

#1

#$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Start Time", "End Time" | Where-Object {$_.Instructor -ilike "*Paligu"}


#2
#$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -ilike "Monday") } | Select-Object "Start Time", "End Time", "Class Code"

#3
<#
$ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or`
    ($_."Class Code" -ilike "SEC*") -or`
    ($_."Class Code" -ilike "FOR*") -or`
    ($_."Class Code" -ilike "CSI*") -or`
    ($_."Class Code" -ilike "DAT*") }`
| Select-Object Instructor | Sort-Object Instructor -Unique
$ITSInstructors
#>
#4
$FullTable | Where {$_.Instructor -in $ITSInstructors.Instructor } | Group-Object -Property "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending