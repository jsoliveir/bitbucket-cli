
Function Get-BitbucketCloudRepositoryInfo {
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
        [Parameter(Mandatory=$true)] [String] $Repository)
    
    return (Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.BaseUrl)/2.0/repositories/${Workspace}/${Repository}")
}