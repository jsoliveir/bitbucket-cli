Describe "Get-BitbucketSession" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\**\Get-BitbucketSession.ps1"
        Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
        $global:BITBUCKETCLI_SESSIONS = @()
        $global:BITBUCKETCLI_SESSIONS +=([PSCustomObject]@{
            IsSelected = $true
            Server = "server"
            Username = "User"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            IsSelected = $false
            Server = "server2"
            Username = "User2"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            IsSelected = $true
            Server = "server3"
            Username = "User3"
        })
    }
    Context "sessions" {
        It "must_list_all_sessions" {
            @(Get-BitbucketSession -All).Count | Should -BeExactly 3
        }
        It "must_list_server_session" {
            @(Get-BitbucketSession -Server "Server2").Count  | Should -BeExactly 1 
            @(Get-BitbucketSession -Server "Server2").Server | Should -BeExactly "server2"
            @(Get-BitbucketSession -Server "Server2").IsSelected | Should -Be $false
        }
        It "must_list_IsSelected_sessions_only" {
            @(Get-BitbucketSession).Count  | Should -BeExactly 2
            @(Get-BitbucketSession).Server | Should -Contain "server"
            @(Get-BitbucketSession).Server | Should -Contain "server3"
        }
    }
}