
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.41/ToBeScraped.html
#$scraped_page.Links | Select-Object "outerText*","href*"
<#
$h2s= $scraped_page.ParsedHtml.body.getElementsbyTagName("h2") | Select outerText
$h2s
#>

$divs1= $scraped_page.ParsedHtml.body.getElementsbyTagName("div") | where {
$_.getAttributeNode("class").Value -ilike "div-1*"} | select innerText

$divs1
