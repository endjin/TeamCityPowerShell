Clear-Host

$path = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module (Join-Path $path "Modules") -Force -DisableNameChecking

$parameters = @{ 
	 ConnectionDetails = @{
		 ServerUrl = "teamcity.codebetter.com"
		 Credential = Get-Credential
	 }
	 BuildConfigId = "bt437"
}

$artifactparameters = @{ 
	 ConnectionDetails = @{
		ServerUrl = "teamcity.codebetter.com"
		Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
		UseSsl = $false
		IsGuest = $false 
	 }
	 BuildConfigId = "bt87"
	 BuildId = "5742"
	 ArtifactName = "FluentDot.sln.dups.xml"
	 SavePath = ("C:\Temp\Get-Artifact\" + $parameters.ArtifactName)
   }
					   
$archiveartifactparameters = @{ 
	 ConnectionDetails = @{
		ServerUrl = "teamcity.codebetter.com"
		Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
		UseSsl = $false
		IsGuest = $false 
	 }
	 BuildConfigId = "bt87"
	 BuildId = "5742"
	 ArchiveName = "FluentDot.sln.dups.zip"
	 ArtifactName = "FluentDot.sln.dups.xml"
	 SavePath = "C:\Temp\Get-ArtifactArchive\FluentDot.sln.dups.zip"
   }

$builds = Get-BuildConfigsByBuildConfigId @parameters

foreach($build in $builds)
{
	Write-Host $build.Number
}

#$builds = Get-AllBuildConfigs @parameters
#$builds = Get-AllBuildsOfStatusSinceDate @parameters
#$builds = Get-AllBuildsSinceDate @parameters
#$build = Get-BuildConfigByConfigurationId @parameters
#$build = Get-BuildConfigByConfigurationName @parameters
#$build = Get-BuildConfigByProjectIdAndConfigurationId @parameters
#$build = Get-BuildConfigByProjectIdAndConfigurationName @parameters
#$builds = Get-BuildConfigsByConfigIdAndTag @parameters
#$build = Get-BuildConfigsByConfigIdAndTags -ConnectionDetails $parameters.ConnectionDetails `
#                                           -BuildConfigId $parameters.BuildConfigId `
#						                    -Tags @("Release", "RC")
#$groups = Get-AllGroupsByUserName @parameters
#$projects = Get-AllProjects @parameters
#$roles = Get-AllRolesByUserName @parameters
#$roles = Get-AllUserRolesByUserGroup @parameters
#$url = New-TeamCityUrl @parameters
#$connection = New-TeamCityConnection @parameters
#Get-ArtifactsByBuildId @parameters
#Get-Artifact @artifactparameters
#Get-ArtifactArchive @archiveartifactparameters
#Get-ArtifactsAsArchive @archiveartifactparameters