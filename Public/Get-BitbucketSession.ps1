Function Get-BitbucketSession {
    param([Parameter(Mandatory=$false)] [String] $Server = "*",
          [Parameter(Mandatory=$false)] [Switch] $All)

    $All = ($All -or ($Server.Length -gt 1 ))
   
    return $global:BITBUCKETCLI_SESSIONS `
    | Where-Object { $_.Active -eq $true -or $All } `
    | Where-Object { $_.Server -like "$Server" }
}
