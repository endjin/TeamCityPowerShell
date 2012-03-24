<pre>
 ______                            ____         __                
/\__  _\                          /\  _`\    __/\ \__             
\/_/\ \/    __     __      ___ ___\ \ \/\_\ /\_\ \ ,_\  __  __    
   \ \ \  /'__`\ /'__`\  /' __` __`\ \ \/_/_\/\ \ \ \/ /\ \/\ \   
    \ \ \/\  __//\ \L\.\_/\ \/\ \/\ \ \ \L\ \\ \ \ \ \_\ \ \_\ \  
     \ \_\ \____\ \__/.\_\ \_\ \_\ \_\ \____/ \ \_\ \__\\/`____ \ 
      \/_/\/____/\/__/\/_/\/_/\/_/\/_/\/___/   \/_/\/__/ `/___/> \
                                                            /\___/
                                                            \/__/ 
 ____                                  ____    __              ___   ___      
/\  _`\                               /\  _`\ /\ \            /\_ \ /\_ \     
\ \ \L\ \___   __  __  __     __  _ __\ \,\L\_\ \ \___      __\//\ \\//\ \    
 \ \ ,__/ __`\/\ \/\ \/\ \  /'__`\\`'__\/_\__ \\ \  _ `\  /'__`\\ \ \ \ \ \   
  \ \ \/\ \L\ \ \ \_/ \_/ \/\  __/ \ \/  /\ \L\ \ \ \ \ \/\  __/ \_\ \_\_\ \_ 
   \ \_\ \____/\ \___x___/'\ \____\ \_\  \ `\____\ \_\ \_\ \____\/\____\\____\
    \/_/\/___/  \/__//__/   \/____/\/_/   \/_____/\/_/\/_/\/____/\/____//____/

</pre>

TeamCityPowerShell v1.0.0.0 - Powered by endjin
===============================================

About 
=====

TeamCityPowerShell is a series of 49 cmdlets that you can use to query TeamCity for information its state.

<pre>
$parameters = @{ 
	 ConnectionDetails = @{
		 ServerUrl = "teamcity.codebetter.com"
		 Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
		 UseSsl = $false
		 IsGuest = $false 
	 }
	 BuildConfigId = "bt437"
}

$builds = Get-BuildConfigsByBuildConfigId @parameters

foreach($build in $builds)
{
	Write-Host $build.Number
}
</pre>


Usage
=====
The following cmdlets are supported:
<pre>
 o Get-AllAgents
 o Get-AllBuildConfigs
 o Get-ArtifactsByBuildId
 o Get-Artifact
 o Get-ArtifactsAsArchive *
 o Get-BuildConfigByConfigurationName
 o Get-AllBuildsOfStatusSinceDate
 o Get-AllBuildsSinceDate
 o Get-AllChanges
 o Get-AllGroupsByUserName
 o Get-AllProjects
 o Get-AllRolesByUserName *
 o Get-AllServerPlugins *
 o Get-AllUserGroups
 o Get-AllUserRolesByUserGroup
 o Get-AllUsers *
 o Get-AllUsersByUserGroup
 o Get-AllVcsRoots
 o Get-BuildConfigByConfigurationId
 o Get-BuildConfigByConfigurationName
 o Get-BuildConfigByProjectIdAndConfigurationId
 o Get-BuildConfigByProjectIdAndConfigurationName
 o Get-BuildConfigByProjectNameAndConfigurationId
 o Get-BuildConfigByProjectNameAndConfigurationName
 o Get-BuildConfigsByBuildConfigId
 o Get-BuildConfigsByConfigIdAndTag
 o Get-BuildConfigsByConfigIdAndTags
 o Get-BuildConfigsByProjectId
 o Get-BuildConfigsByProjectName
 o Get-BuildsByBuildLocator *
 o Get-BuildsByUserName
 o Get-ChangeDetailsByBuildConfigId
 o Get-ChangeDetailsByChangeId
 o Get-ErrorBuildsByBuildConfigId *
 o Get-FailedBuildsByBuildConfigId *
 o Get-LastBuildByAgent
 o Get-LastBuildByBuildConfigId
 o Get-LastChangeDetailByBuildConfigId
 o Get-LastErrorBuildByBuildConfigId *
 o Get-LastFailedBuildByBuildConfigId
 o Get-LastSuccessfulBuildByBuildConfigId
 o Get-LatestArtifact
 o Get-NonSuccessfulBuildsForUser
 o Get-ProjectById
 o Get-ProjectByName
 o Get-ServerInfo
 o Get-SuccessfulBuildsByBuildConfigId
 o Get-VcsRootById
 o New-TeamCityUrl
 o New-TeamCityWebClientConnection
</pre> 
To discover what parameters are required for each cmdlet use the Get-Help cmdlet i.e.:
 
	Get-Help Get-BuildConfigsByBuildConfigId

which will return

	Get-BuildConfigsByBuildConfigId [[-ConnectionDetails] <Hashtable>] [[-BuildConfigId] <String>]

The ConnectionDetails hashtable requires the following values

	ConnectionDetails = @{
		ServerUrl = "teamcity.codebetter.com"
		Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
		UseSsl = $false
		IsGuest = $false 
	}

At a minimum the following values are required:

	ConnectionDetails = @{
		ServerUrl = "teamcity.codebetter.com"
		Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
	}

If you don't want to embedd TeamCity credentials you can enter them interactively using:

	$parameters = @{ 
		ConnectionDetails = @{
			ServerUrl = "teamcity.codebetter.com"
			Credential = Get-Credential
		}
		BuildConfigId = "bt437"
	}

Alternatively you can retrieve them disk using this PowerShell Cookbook recipie: http://www.leeholmes.com/blog/2008/06/04/importing-and-exporting-credentials-in-powershell/

For full documentation on how to use each Cmdlet see the Pester Specifications contained within TeamCity.Tests.ps1 and TeamCity-Artifacts.Tests.ps1

To run the full suite of BDD specs invoke "run-specs.bat" in the root of this project.

 * denotes that the function has a ignored specification pending investigation
 
 
Ingredients
===========
TeamCityPowerShell makes use of the following tools and frameworks:

 o TeamCitySharp - https://github.com/stack72/TeamCitySharp 
 o Pester - https://github.com/scottmuc/Pester 


Install
=======

TeamCityPowerShell depends on TeamCitySharp which is a .NET 4.0 application. By default PowerShell only supports .NET 2.0 - to enable .NET 4.0 support copy TeamCityPowerShell\SetUp\PowerShell.exe.config to the PowerShell install directory - this allows PowerShell to host the .NET 4.0 runtime.

To import the module use standard PowerShell syntax:

	Import-Module C:\Code\OSS\TeamCityPowerShell\Modules\TeamCity

Or if you wish to load everything from the Modules directory, which will sit under your consuming script - you can use the following commands:
	
	$path = Split-Path -Parent $MyInvocation.MyCommand.Path
	Import-Module (Join-Path $path "Modules") -Force -DisableNameChecking


Contribute
==========
http://github.com/endjin/TeamCityPowerShell


Support / Help
==============
Follow http://twitter.com/endjin on twitter.

Report bugs & issues on https://github.com/endjin/TeamCityPowerShell/issues


Credits & Thanks
================
James Dawson for being the usual partner in crime

Paul Stack & Contributors for TeamCitySharp

Copyright (c) 2012 endjin (@endjin)


Version History
===============
2012.03.24 - v1.0.0.0 - First public release