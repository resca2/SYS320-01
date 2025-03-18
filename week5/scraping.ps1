function gatherClasses() {
$page = Invoke-WebRequest -TimeoutSec 5 http://10.0.17.41/Courses.html 

#get all tr elements of html doc
$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()
for($i = 1; $i -lt $trs.length; $i++){ #going over every tr elements

#get every td element of current tr element
$tds = $trs[$i].getElementsByTagName("td") 
#seperate start and end time from one time field.
$Times= $tds[5].innerText.Split("-")

$FullTable += [pscustomobject]@{
"Class code" = $tds[0].innerText
"Title" = $tds[1].innerText
"Days" = $tds[4].innerText
"Start Time" = $Times[0]
"End Time" = $Times[1]
"Instructor" = $tds[6].innerText
"Location" = $tds[9].innerText
}
}
return $FullTable
}



function daysTranslator($FullTable){
for($i=0; $i -lt $FullTable.length; $i++){
    $Days = @()
    if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday" }
    if($FullTable[$i].Days -ilike "*T[WTF]*"){$Days += "Tuesday" }
    ElseIf($FullTable[$i].Days -ilike "T"){$Days += "Tuesday"}
    if($FullTable[$i].Days -ilike "*W*"){$Days += "Wednesday"}
    if($FullTable[$i].Days -ilike "*TH*"){$Days += "Thursday"}
    if($FullTable[$i].Days -ilike "*F"){$Days += "Friday"}
    $FullTable[$i].Days = $Days
    }
return $FullTable
}
