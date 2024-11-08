function New-ZorusDeploymentToken {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$GroupUuid,
        [Parameter(Mandatory=$true)]$Name
    )
    $URI=$script:BaseURL+'/api/deployment-tokens'
    $body=@{}
    $body.add('groupUuid', $GroupUuid)
    $body.add('name',$Name)
    $results=New-ZorusQuery -method POST -body $Body -uri $URI
    $results
}