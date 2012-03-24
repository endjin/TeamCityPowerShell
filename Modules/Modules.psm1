# Load in the functions
$modules = Get-ChildItem -Recurse $PSScriptRoot -Include *.psd1

foreach ($module in $modules) 
{
	Import-Module $module.FullName
}

$env:PSUTILSPATH = $PSScriptRoot