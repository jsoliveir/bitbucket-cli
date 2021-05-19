Function New-BitbucketCloudPullRequest {
    param([Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $SourceBranch,
          [Parameter(Mandatory=$true)] [String] $TargetBranch,
          [Parameter(Mandatory=$false)] [String] $Description,
          [Parameter(Mandatory=$false)] [String[]] $Reviewers = @(),
          [Parameter(Mandatory=$false)] [String] $Title)
  
        $payload = [PSCustomObject]@{
            "title"=$Title
            "description"=$Description
            "source"= [PSCustomObject]@{
                "branch"=[PSCustomObject]@{
                    "name"= $SourceBranch
                }
            }
            "destination"= [PSCustomObject]@{
                "branch"=[PSCustomObject]@{
                    "name"= $TargetBranch
                }
            }
            "reviewers" = $Reviwers
            "close_source_branch"=$false
        }

    return ($payload | ConvertTo-Json | Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pullrequests" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        })
}
