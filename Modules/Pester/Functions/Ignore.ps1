function Ignore($name, [ScriptBlock] $fixture) {

    $results = Get-GlobalTestResults
	$margin = " " * $results.TestDepth
    $results.TestDepth += 1

	$output = $margin + "Ignoring " + $name

    Write-Host -fore gray $output
	
    $results.TestDepth -= 1
}
