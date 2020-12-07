<#
    Check the following BITBUCKET API documentation to develop new features:
    https://developer.atlassian.com/bitbucket/api/2/reference/resource/
#>

$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\ -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue -Verbose:$false )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue -Verbose:$false )

if($VerbosePreference){
    Write-Host -ForegroundColor cyan "Importing Bitbucket Cloud CLI ..."
}
$Public | Sort-Object -Property Basename | Foreach-Object{
    if($VerbosePreference){
        Write-Host -ForegroundColor Magenta "* $($_.Basename)"
    }
    . $_.FullName
}
$Private | Sort-Object -Property Basename | Foreach-Object{
    . $_.FullName
}

Remove-Item Alias:curl -ErrorAction Ignore -Verbose:$false

Export-ModuleMember -Function $Public.Basename -Verbose:$false