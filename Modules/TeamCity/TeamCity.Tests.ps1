$path = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module (Join-Path $path "..\..\Modules") -Force -DisableNameChecking

$ConnectionDetails = @{
					  	ServerUrl = "teamcity.codebetter.com"
						Credential = New-Object System.Management.Automation.PSCredential("teamcitysharpuser", (ConvertTo-SecureString "qwerty" -asplaintext -force))
						UseSsl = $false
						IsGuest = $false 
				      }

Describe "Get-AllAgents" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-AllAgents @parameters

    It "should return multiple agents" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-AllBuildConfigs" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$builds = Get-AllBuildConfigs @parameters

    It "should return multiple build configurations" { 
       $builds.Count.should.have_count_greater_than(1)
    }
	
	It "should return build configurations with valid identity" { 
       $builds[0].Id.should.match("bt409")
    }
}

Describe "Get-BuildConfigByConfigurationName" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigName = "Release Build"
				   }

	$result = Get-BuildConfigByConfigurationName @parameters

    It "should return a build configuration with a matching configuration name" { 
       $result.should.match($parameters.BuildConfigName)
    }
}

Describe "Get-AllBuildsOfStatusSinceDate" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails
					 Date = [DateTime]::Now.AddDays(-3)
					 BuildStatus = "Success"
				   }

	$result = Get-AllBuildsOfStatusSinceDate @parameters

    It "should return multiple build configurations" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-AllBuildsSinceDate" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails
					 Date = [DateTime]::Now.AddDays(-3)
				   }

	$result = Get-AllBuildsSinceDate @parameters

    It "should return multiple build configurations" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-AllChanges" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-AllChanges @parameters

    It "should return multiple changes" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-AllGroupsByUserName" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 UserName = "teamcitysharpuser" #must be lowercase 
				   }

	$result = Get-AllGroupsByUserName @parameters

    It "should return all users group for standard user" { 
       $result.Name.should.match("All Users")
    }
}

Describe "Get-AllProjects" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-AllProjects @parameters

    It "should return multiple projects" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Ignore "Get-AllRolesByUserName" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 UserName = "teamcitysharpuser" 
				   }

	$result = Get-AllRolesByUserName @parameters

    It "should return matching roles" { 
       $result.should.match("PROJECT_VIEWER")
    }
}

Ignore "Get-AllServerPlugins" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-AllServerPlugins @parameters

    It "should " { 
       $result.should.match("NOT IMPLEMENTED")
    }
}

Describe "Get-AllUserGroups" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-AllUserGroups @parameters

    It "should return global user group" { 
       $result.should.match("All Users")
    }
}

Describe "Get-AllUserRolesByUserGroup" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 UserGroupName = "ALL_USERS_GROUP" 
				   }

	$result = Get-AllUserRolesByUserGroup @parameters

    It "should return global role" { 
       $result.RoleId.should.match("PROJECT_VIEWER")
    }
}

Ignore "Get-AllUsers" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-AllUsers @parameters

    It "should " { 
       $result.should.match("NOT IMPLEMENTED")
    }
}

Describe "Get-AllUsersByUserGroup" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 UserGroupName = "ALL_USERS_GROUP" 
				   }

	$result = Get-AllUsersByUserGroup @parameters

    It "should return multiple users" { 
      $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-AllVcsRoots" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-AllVcsRoots @parameters

    It "should return multiple VCS Roots" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-BuildConfigByConfigurationId" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigId = "bt437"
                   }

	$build = Get-BuildConfigByConfigurationId @parameters
	
	It "should return a single build configuration with a matching id" { 
       $build.Id.should.match($parameters.BuildConfigId)
    }
}

Describe "Get-BuildConfigByConfigurationName" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigName = "Release Build"
                   }

	$build = Get-BuildConfigByConfigurationName @parameters
	
	It "should return a single build configuration with a matching name" { 
       $build.Name.should.match($parameters.BuildConfigName)
    }
}

Describe "Get-BuildConfigByProjectIdAndConfigurationId" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigId = "bt437"
					  ProjectId = "project137"
                   }

	$build = Get-BuildConfigByProjectIdAndConfigurationId @parameters
	
	It "should return a single build configuration with a matching build config id" { 
       $build.Id.should.match($parameters.BuildConfigId)
    }
	
	It "should return a single build configuration with a project id" { 
       $build.Project.Id.should.match($parameters.ProjectId)
    }
}

Describe "Get-BuildConfigByProjectIdAndConfigurationName" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigName = "Release Build"
					  ProjectId = "project137"
                   }

	$build = Get-BuildConfigByProjectIdAndConfigurationName @parameters
	
	It "should return a single build configuration with a matching build config name" { 
       $build.Name.should.match($parameters.BuildConfigName)
    }
	
	It "should return a single build configuration with a project id" { 
       $build.Project.Id.should.match($parameters.ProjectId)
    }
}

Describe "Get-BuildConfigByProjectNameAndConfigurationId" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigId = "bt437"
					  ProjectName = "YouTrackSharp"
                   }

	$build = Get-BuildConfigByProjectNameAndConfigurationId @parameters
	
	It "should return a single build configuration with a matching build config ids" { 
       $build.Id.should.match($parameters.BuildConfigId)
    }
	
	It "should return a single build configuration with a project name" { 
       $build.Project.Name.should.match($parameters.ProjectName)
    }
}

Describe "Get-BuildConfigByProjectNameAndConfigurationName" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigName = "Release Build"
					  ProjectName = "YouTrackSharp"
                   }

	$build = Get-BuildConfigByProjectNameAndConfigurationName @parameters
	
	It "should return a single build configuration with a matching build config name" { 
       $build.Name.should.match($parameters.BuildConfigName)
    }
	
	It "should return a single build configuration with a project name" { 
       $build.Project.Name.should.match($parameters.ProjectName)
    }
}

Describe "Get-BuildConfigsByBuildConfigId" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigId = "bt437"
                   }

	$builds = Get-BuildConfigsByBuildConfigId @parameters

    It "should return multiple build configurations" { 
       $builds.Count.should.have_count_greater_than(1)
    }
	
	It "should return build configurations with valid build numbers" { 
       $builds[0].should.match("(\d\d*?).(\d\d*?).(\d\d*?).(\d\d*?)")
    }
}

Describe "Get-BuildConfigsByConfigIdAndTag" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigId = "bt437"
					  Tag = "Release"
                   }

	$builds = Get-BuildConfigsByConfigIdAndTag @parameters

    It "should return multiple build configurations" { 
       $builds.Count.should.have_count_greater_than(1)
    }
	
	It "should return a build configuration with a matching build configuration id" { 
       $builds[0].BuildTypeId.should.match($parameters.BuildConfigId)
    }
}

Describe "Get-BuildConfigsByConfigIdAndTags" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      BuildConfigId = "bt437"
					  Tags = @("RC", "Temp")
                   }

	$builds = Get-BuildConfigsByConfigIdAndTags @parameters

	It "should return a build configuration with a matching build configuration id" { 
       $builds.BuildTypeId.should.match($parameters.BuildConfigId)
    }
}

Describe "Get-BuildConfigsByProjectId" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      ProjectId = "project137"
                   }

	$builds = Get-BuildConfigsByProjectId @parameters

	It "should return a build configuration with a matching project id" { 
       $builds.ProjectId.should.match($parameters.ProjectId)
    }
}

Describe "Get-BuildConfigsByProjectName" {

	$parameters = @{ 
                      ConnectionDetails = $ConnectionDetails
				      ProjectName = "YouTrackSharp"
                   }

	$builds = Get-BuildConfigsByProjectName @parameters

	It "should return a build configuration with a matching project name" { 
       $builds.ProjectName.should.match($parameters.ProjectName)
    }
}

Ignore "Get-BuildsByBuildLocator" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-BuildsByBuildLocator @parameters

    It "should " { 
       $result.should.match("NOT IMPLEMENTED")
    }
}

Describe "Get-BuildsByUserName" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 UserName = "hhariri" 
				   }

	$result = Get-BuildsByUserName @parameters

    It "should return multiple builds" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-ChangeDetailsByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt437" 
				   }

	$result = Get-ChangeDetailsByBuildConfigId @parameters

    It "should return multiple change details" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-ChangeDetailsByChangeId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails
					 Id = "41257"
				   }

	$result = Get-ChangeDetailsByChangeId @parameters

    It "should return a change detail with a maching Id " { 
       $result.Id.should.match($parameters.Id)
    }
}

Ignore "Get-ErrorBuildsByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt409" 
				   }

	$result = Get-ErrorBuildsByBuildConfigId @parameters

    It "should return multiple builds" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Ignore "Get-FailedBuildsByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt409" 
				   }

	$result = Get-FailedBuildsByBuildConfigId @parameters

    It "should return multiple builds" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-LastBuildByAgent" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 AgentName = "agent01" 
				   }

	$result = Get-LastBuildByAgent @parameters

    It "should return valid build info" { 
       $result.Id.should.not_be_empty()
    }
}

Describe "Get-LastBuildByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt437" 
				   }

	$result = Get-LastBuildByBuildConfigId @parameters

    It "should return build with a valid build numbers" { 
       $result.should.match("(\d\d*?).(\d\d*?).(\d\d*?).(\d\d*?)")
    }
}

Describe "Get-LastChangeDetailByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt437" 
				   }

	$result = Get-LastChangeDetailByBuildConfigId @parameters

    It "should return a change detail with a valid id" { 
       $result.Id.should.not_be_empty()
    }
}

Ignore "Get-LastErrorBuildByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt409" 
				   }

	$result = Get-LastErrorBuildByBuildConfigId @parameters

    It "should " { 
       $result.should.match("NOT IMPLEMENTED")
    }
}

Describe "Get-LastFailedBuildByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt409" 
				   }

	$result = Get-LastFailedBuildByBuildConfigId @parameters

    It "should return build with a valid build numbers" { 
       $result.Id.should.not_be_empty()
    }
}

Describe "Get-LastSuccessfulBuildByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt437" 
				   }

	$result = Get-LastSuccessfulBuildByBuildConfigId @parameters

    It "should return build with a valid build numbers" { 
       $result.should.match("(\d\d*?).(\d\d*?).(\d\d*?).(\d\d*?)")
    }
}

Describe "Get-NonSuccessfulBuildsForUser" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 UserName = "hhariri" 
				   }

	$result = Get-NonSuccessfulBuildsForUser @parameters

    It "should return multiple builds" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-ProjectById" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 ProjectLocatorId = "project137" 
				   }

	$result = Get-ProjectById @parameters

    It "should return a project with a matching id" { 
       $result.Id.should.match($parameters.ProjectLocatorId)
    }
}

Describe "Get-ProjectByName" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 ProjectLocatorName = "YouTrackSharp" 
				   }

	$result = Get-ProjectByName @parameters

    It "should return a project with a matching name" { 
       $result.Name.should.match($parameters.ProjectLocatorName)
    }
}

Describe "Get-ServerInfo" {

	$parameters = @{ ConnectionDetails = $ConnectionDetails }

	$result = Get-ServerInfo @parameters

    It "should return a server info object" { 
       $result.should.match("TeamCitySharp.DomainEntities.Server")
    }
}

Describe "Get-SuccessfulBuildsByBuildConfigId" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 BuildConfigId = "bt437" 
				   }

	$result = Get-SuccessfulBuildsByBuildConfigId @parameters

    It "should return multiple builds" { 
       $result.Count.should.have_count_greater_than(1)
    }
}

Describe "Get-VcsRootById" {

	$parameters = @{ 
	                 ConnectionDetails = $ConnectionDetails 
					 VcsRootId = "1" 
				   }

	$result = Get-VcsRootById @parameters

    It "should return a VCSRoot with a mathcing Id" { 
       $result.Id.should.match($parameters.VcsRootId)
    }
}