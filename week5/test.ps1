function gatherClasses() {
$page = Invoke-WebRequest -TimeoutSec 5 http://10.0.17.41/Courses.html
$trs = $page.ParsedHtml.body.getElementsByTagName("tr")
$FullTable =@()

for ($i = 1; $i -lt $trs.length; $i++) {
$tds = $trs[$i].getElementsByTagName("td")

$Times = if ($tds[5].innerText) { $tds[5].innerText.Split("-")}

$FullTable += [pscustomobject]@{
"Class Code" = $tds[0].innerText
"Title"= $tds[1].innerText
"Day" = $tds[4].innerText
"Start Time" = $Times[0]
"End Time" =$Times[1]
"Instructor" = $tds[6].innerText
"Location" = $tds[9].innerText
}
}
return $FullTable
}