function GetIOC {
param (
[string]$Url = "10.0.17.6/IOC.html"
)
$html = Invoke-Webrequest -Uri $Url
$iocTable = $html.ParsedHtml.getElementsByTagName("table")[0]
$results = @()

foreach ($row in $iocTable.rows) {
if ($row.rowIndex -gt 0) {

$pattern = $row.cells[0].innerText
$explanation = $row.cells[1].innerText

$results += [PSCustomObject]@{
Pattern = $pattern
Explanation = $explanation
}
}
}
return $results
}
