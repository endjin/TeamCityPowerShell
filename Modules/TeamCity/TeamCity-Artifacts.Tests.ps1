$path = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module (Join-Path $path "..\..\Modules") -Force -DisableNameChecking

Describe "New-TeamCityWebClientConnection" {

	When "given connection details with guest authentication, credentials should be null" { 
	
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							IsGuest = $true
							UseSsl = $false
					   }}
					   
		$connection = New-TeamCityWebClientConnection @parameters
		
		if (![string]::IsNullOrEmpty($connection.Credentials)){
			throw New-Object PesterFailure("expected to be null or empty", "")
		}
    }
	
	When "given connection details with credentials, credential should be populated" { 
	
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
							UseSsl = $false
					   }}
	
		$connection = New-TeamCityWebClientConnection @parameters
		
		$connection.Credentials.UserName.should.match("teamcitysharpuser")
    }
}

Describe "New-TeamCityUrl" {

 	When "given secure connection details, it should generate a secure url" { 
	
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							UseSsl = $true
					   }}
							  
		$result = New-TeamCityUrl @parameters

        $result.should.match('https://teamcity.codebetter.com')
    }
	
	When "given unsecure connection details, it should generate a unsecure url" {
	
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							UseSsl = $false
					   }}
		
		$result = New-TeamCityUrl @parameters
		
		$result.should.match('http://teamcity.codebetter.com')
    }
}

Describe "Get-ArtifactsByBuildId" {

 	When "asked to download all artifacts for a given build id, it should download the artifacts" { 
		
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
					 		UseSsl = $false
					 		IsGuest = $false 
					     }
						 BuildId = "5742"
						 SavePath = "C:\Temp\Get-ArtifactsByBuildId\archive.zip"
					   }
		
		if (!(Test-Path "C:\Temp\Get-ArtifactsByBuildId\"))
    	{
	    	New-Item "C:\Temp\Get-ArtifactsByBuildId\" -type directory | Out-Null
		}
							  
		Get-ArtifactsByBuildId @parameters
		
        $parameters.SavePath.should.exist()
		
		Remove-Item $parameters.SavePath -Force
    }
}

Describe "Get-Artifact" {

 	When "asked to download a specific artifact for a given build configuration and build id, it should download the artifact" { 
		
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
					 		UseSsl = $false
					 		IsGuest = $false 
					     }
						 BuildConfigId = "bt87"
						 BuildId = "5742"
						 ArtifactName = "FluentDot.sln.dups.xml"
						 SavePath = "C:\Temp\Get-Artifact\FluentDot.sln.dups.xml"
					   }
		
		if (!(Test-Path "C:\Temp\Get-Artifact\"))
    	{
	    	New-Item "C:\Temp\Get-Artifact\" -type directory | Out-Null
		}
							  
		Get-Artifact @parameters
		
        $parameters.SavePath.should.exist()
		
		Remove-Item $parameters.SavePath -Force
    }
}

Describe "Get-ArtifactByBuildNumber" {

 	When "asked to download a specific artifact for a given build configuration and build number, it should download the artifact" { 
		
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
					 		UseSsl = $false
					 		IsGuest = $false 
					     }
						 BuildConfigId = "bt87"
						 BuildNumber = "4"
						 ArtifactName = "FluentDot.sln.dups.xml"
						 SavePath = "C:\Temp\Get-ArtifactByBuildNumber\FluentDot.sln.dups.xml"
					   }
		
		if (!(Test-Path "C:\Temp\Get-ArtifactByBuildNumber\"))
    	{
	    	New-Item "C:\Temp\Get-ArtifactByBuildNumber\" -type directory | Out-Null
		}
							  
		Get-ArtifactByBuildNumber @parameters
		
        $parameters.SavePath.should.exist()
		
		Remove-Item $parameters.SavePath -Force
    }
}

Describe "Get-LatestArtifact" {

 	When "asked to download a specific artifact as an archive for a given build configuration and build id, it should download the artifact" { 
		
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
					 		UseSsl = $false
					 		IsGuest = $false 
					     }
						 BuildConfigId = "bt87"
						 ArtifactName = "FluentDot.sln.dups.xml"
						 SavePath = "C:\Temp\Get-LatestArtifact\FluentDot.sln.dups.xml"
					   }
		
		if (!(Test-Path "C:\Temp\Get-LatestArtifact\"))
    	{
	    	New-Item "C:\Temp\Get-LatestArtifact\" -type directory | Out-Null
		}
							  
		Get-LatestArtifact @parameters
		
        $parameters.SavePath.should.exist()
		
		Remove-Item $parameters.SavePath -Force
    }
}

Ignore "Get-ArtifactsAsArchive" {

 	When "asked to download the artifacts, for a given build id, as an archive, it should download the artifact archive" { 
		
		$parameters = @{ 
						 ConnectionDetails = @{
						 	ServerUrl = "teamcity.codebetter.com"
							Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
					 		UseSsl = $false
					 		IsGuest = $false 
					     }
						 BuildConfigId = "bt87"
						 BuildId = "5742"
						 SavePath = "C:\Temp\Get-ArtifactsAsArchive\FluentDot.sln.dups.zip"
					   }
		
		if (!(Test-Path "C:\Temp\Get-ArtifactsAsArchive\"))
    	{
	    	New-Item "C:\Temp\Get-ArtifactsAsArchive\" -type directory | Out-Null
		}
							  
		Get-ArtifactsAsArchive @parameters
		
        $parameters.SavePath.should.exist()
		
		Remove-Item $parameters.SavePath -Force
    }
}